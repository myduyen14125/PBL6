import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from "@nestjs/common";
import { CourseService } from "src/course/services/course.service";
import { User } from "src/user/user.model";
import { v4 as uuidv4 } from 'uuid';
import { PaymentDto, RequestPaymentDto } from "./payment.dto";
import { PaymentRepository } from "./payment.repository";


@Injectable()
export class PaymentService {
    constructor(
        private readonly paymentRepository: PaymentRepository,
        @Inject(forwardRef(() => CourseService)) private readonly courseService: CourseService,
    ) { }

    async makePayment(user: User, requestDto: RequestPaymentDto) {

        const course = await this.courseService.getCoursePriceAndDiscountById(requestDto.course)
        const discount = course.discount ?? 0
        const total = course.price * (100-discount)/100

        if(total === 0) return await this.handlePostPayment({amount: 0,user: user.id, course: course.id})
        const newUuid1: string = uuidv4();
        const newUuid2: string = uuidv4();
        const partnerCode = process.env.PARTNER_CODE;
        const accessKey = process.env.ACCESS_KEY;
        const secretKey = process.env.SECRET_KEY;
        var requestId = newUuid1.replace(/-/g, '');
        var orderId = newUuid2.replace(/-/g, '');
        var orderInfo = "pay with MoMo";
        const redirectUrl = process.env.REDIRECT_URL;
        const ipnUrl = process.env.IPN_URL
        var amount = total.toString();
        var requestType = "payWithATM"
        var extraData = "user:" + user.id + "course:" + course.id;
        var rawSignature = "accessKey=" + accessKey + "&amount=" + amount + "&extraData=" + extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + requestId + "&requestType=" + requestType
        // console.log("--------------------RAW SIGNATURE----------------")
        const crypto = require('crypto');
        var signature = crypto.createHmac('sha256', secretKey)
            .update(rawSignature)
            .digest('hex');
        console.log(signature);
        
        // console.log("--------------------SIGNATURE----------------")
        const requestBody = JSON.stringify({
            partnerCode: partnerCode,
            accessKey: accessKey,
            requestId: requestId,
            amount: amount,
            orderId: orderId,
            orderInfo: orderInfo,
            redirectUrl: redirectUrl,
            ipnUrl: ipnUrl,
            extraData: extraData,
            requestType: requestType,
            signature: signature,
            lang: 'en'
        });

        const https = require('https');
        const options = {
            hostname: 'test-payment.momo.vn',
            port: 443,
            path: '/v2/gateway/api/create',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': Buffer.byteLength(requestBody)
            }
        }
        return new Promise((resolve, reject) => {
            const req = https.request(options, res => {
                let data = '';

                res.on('data', chunk => {
                    data += chunk;
                });

                res.on('end', () => {
                    const response = JSON.parse(data);
                    resolve({ url: response.payUrl });
                });
            });

            req.on('error', (e) => {
                reject(e);
            });

            req.write(requestBody);
            req.end();
        });
    }

    async handlePostPayment(ipnData: any) {
        console.log(ipnData);
        if(ipnData.amount === 0) {
            await this.courseService.registerCourse(ipnData.user, ipnData.course)
            return "Success"
        }
        if(ipnData.resultCode != '0') throw new HttpException('Fail transaction', HttpStatus.BAD_REQUEST);

        const parts = ipnData.extraData.split(":");
        const user = parts[1].slice(0, -6);
        const course = parts[2].split("course:").toString();
    
        let dto = new PaymentDto
        dto.user = user
        dto.partnerCode= ipnData.partnerCode;
        dto.orderId= ipnData.orderId;
        dto.orderInfo= ipnData.orderInfo;
        dto.amount= ipnData.amount.toString();
        dto.requestId= ipnData.requestId;
        dto.requestType= ipnData.requestType;
        dto.signature= ipnData.signature;
        dto.transId= ipnData.transId;
        dto.payType= ipnData.payType;
        
        await this.paymentRepository.create(dto)
        await this.courseService.registerCourse(user, course)
        return "Purchase Complete"
    }
} 
