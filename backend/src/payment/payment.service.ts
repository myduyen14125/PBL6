import { Injectable } from "@nestjs/common";
import { PaymentDto } from "./payment.dto";

@Injectable()
export class PaymentService {
    constructor(

    ) { }

    async makePayment(payment: PaymentDto) {
        const partnerCode = process.env.PARTNER_CODE;
        const accessKey = process.env.ACCESS_KEY;
        const secretKey = process.env.SECRET_KEY;
        var requestId = partnerCode + new Date().getTime();
        var orderId = requestId;
        var orderInfo = "pay with MoMo";
        const redirectUrl = process.env.REDIRECT_URL;
        const ipnUrl = process.env.IPN_URL;
        // var ipnUrl = redirectUrl = "https://webhook.site/454e7b77-f177-4ece-8236-ddf1c26ba7f8";
        var amount = payment.amount.toString();
        var requestType = "payWithATM"
        var extraData = "";
        var rawSignature = "accessKey=" + accessKey + "&amount=" + amount + "&extraData=" + extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + requestId + "&requestType=" + requestType
        // console.log("--------------------RAW SIGNATURE----------------")
        const crypto = require('crypto');
        var signature = crypto.createHmac('sha256', secretKey)
            .update(rawSignature)
            .digest('hex');
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
} 