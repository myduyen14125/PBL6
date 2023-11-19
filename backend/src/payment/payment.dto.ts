import { IsNotEmpty } from "class-validator";

export class PaymentDto {
    partnerCode: string;
    orderId: string;
    orderInfo: string;
    amount: string;
    requestId: string;
    requestType: string;
    extraData: string;
    signature: string;
    transId: string;
    payType: string;
    user: any
}

export class RequestPaymentDto {
    @IsNotEmpty() course: string
}

