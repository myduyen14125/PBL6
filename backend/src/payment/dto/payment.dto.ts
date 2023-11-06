import { IsNotEmpty } from "class-validator";

export class PaymentDto {
    partnerCode: string;
    accessKey: string;
    requestId: string;
    amount: string;
    orderId: string;
    orderInfo: string;
    redirectUrl: string;
    ipnUrl: string;
    extraData: string;
    requestType: string;
    signature: string;
    lang: 'en'
}
