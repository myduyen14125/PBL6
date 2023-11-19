import { Body, Controller, Post, ValidationPipe } from "@nestjs/common";
import { PaymentService } from "./payment.service";
import { PaymentDto } from "./payment.dto";


@Controller('payment')
export class PaymentController {
    constructor(private readonly paymentService: PaymentService) { }

    @Post()
    async makePayment(@Body(new ValidationPipe()) payment: PaymentDto) {
        return this.paymentService.makePayment(payment);
    }
    @Post('test')
    handleIPN(@Body() ipnData: any) {
        console.log('Received IPN:', ipnData);
        return 'OK';
    }

}
