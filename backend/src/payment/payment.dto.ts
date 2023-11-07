import { IsNotEmpty, IsNumber } from "class-validator";

export class PaymentDto {
    @IsNotEmpty()
    @IsNumber()
    amount: Number


}
