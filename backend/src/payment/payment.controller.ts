import { Body, Controller, Post, Req, UseGuards, ValidationPipe } from "@nestjs/common";
import { PaymentService } from "./payment.service";
import { PaymentDto, RequestPaymentDto } from "./payment.dto";
import { AuthGuard } from "@nestjs/passport";


@Controller('payment')
export class PaymentController {
    constructor(private readonly paymentService: PaymentService) { }

    @Post()
    @UseGuards(AuthGuard("jwt"))
    async makePayment(@Req() req: any, @Body(new ValidationPipe()) requestPayment: RequestPaymentDto) {
        return this.paymentService.makePayment(req.user, requestPayment);
    }

    @Post('/ipn')
    async handlePostPayment(@Body() ipnData: any) {
        return this.paymentService.handlePostPayment(ipnData)
    }


}
