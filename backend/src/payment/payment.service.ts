import { HttpException, HttpStatus, Inject, Injectable, Logger, forwardRef } from "@nestjs/common";
import { PaymentDto, RequestPaymentDto } from "./payment.dto";
import { PaymentRepository } from './payment.repository';
import { CourseService } from "src/course/services/course.service";
import { v4 as uuidv4 } from 'uuid';
import { User } from "src/user/user.model";


@Injectable()
export class PaymentService {
    constructor(
        // private readonly paymentRepository: PaymentRepository,
        @Inject(forwardRef(() => CourseService)) private readonly courseService: CourseService,
    ) { }

    async makePayment(user: User, requestDto: RequestPaymentDto) {

        const course = await this.courseService.getCoursePriceAndDiscountById(requestDto.course)
        
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
        var amount = course.price.toString();
        var requestType = "payWithATM"
        var extraData = "user:" + user.id + "course:" + course.id;
        var rawSignature = "accessKey=" + accessKey + "&amount=" + amount + "&extraData=" + extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + requestId + "&requestType=" + requestType
        // console.log("--------------------RAW SIGNATURE----------------")
        const crypto = require('crypto');
        var signature = crypto.createHmac('sha256', secretKey)
            .update(rawSignature)
            .digest('hex');
        console.log(signature);

        // Add to database
        // const paymentDto = new PaymentDto
        // paymentDto.partnerCode = partnerCode
        // paymentDto.amount = amount
        // paymentDto.requestId = requestId
        // paymentDto.orderId = orderId
        // paymentDto.orderInfo = orderInfo
        // paymentDto.requestType = requestType
        // paymentDto.extraData = extraData
        // paymentDto.signature = signature
        // paymentDto.user = user.id
        // await this.paymentRepository.create(paymentDto)
        
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
        // if(ipnData.resultCode !== '0') throw new HttpException('Fail transaction', HttpStatus.BAD_REQUEST);
        const accessKey = process.env.ACCESS_KEY;
        const secretKey = process.env.SECRET_KEY;
        const redirectUrl = process.env.REDIRECT_URL;
        const ipnUrl = process.env.IPN_URL
        var requestType = "payWithATM"

        var rawSignature = "accessKey=" + accessKey + "&amount=" + ipnData.amount + "&extraData=" + ipnData.extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + ipnData.orderId + "&orderInfo=" + ipnData.orderInfo + "&partnerCode=" + ipnData.partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + ipnData.requestId + "&requestType=" + requestType
        const crypto = require('crypto');
        var signature = crypto.createHmac('sha256', secretKey)
            .update(rawSignature)
            .digest('hex');
        Logger.log(signature);
        Logger.log(ipnData.signature);

        if(signature !== ipnData.signature) throw new HttpException('Unmatching signature', HttpStatus.BAD_REQUEST);
        const regex = /user%3A([^%]+)course%3A([^%]+)/;
        const match = ipnData.extraData.match(regex);
        const user = match[1];
        const course = match[2];
        Logger.log(user);
        Logger.log(course);
        
        await this.courseService.registerCourse(user, course)
        return "Purchase Complete"
    }
} 
