import { Controller, Post } from "@nestjs/common";
import { PaymentService } from "../services/payment.service";


@Controller('payment')
export class PaymentController {
    constructor(private readonly paymentService: PaymentService) { }

    @Post()
    async testPayment() {
        return this.paymentService.testPayment();
    }


}
