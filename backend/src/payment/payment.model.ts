import { Schema, Document } from "mongoose";
import { User } from "src/user/user.model";

const PaymentSchema = new Schema(
    {
        partnerCode: String,
        orderId: String,
        orderInfo: String,
        amount: String,
        requestId: String,
        requestType: String,
        extraData: String,
        signature: String,
        transId: String,
        payType: String,
        user: { type: Schema.Types.ObjectId, ref: 'User' }
    },
    {
        timestamps: true,
        collection: 'payments',
    }
)

export { PaymentSchema };
export interface Payment extends Document {
    partnerCode: string,
    orderId: string,
    orderInfo: string,
    amount: string,
    requestId: string,
    requestType: string,
    extraData: string,
    signature: string,
    transId: string,
    payType: string,
    user: User
}