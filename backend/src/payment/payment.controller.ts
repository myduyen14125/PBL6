import { Body, Controller, Post, Req, UseGuards } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { RequestPaymentDto } from "./payment.dto";
import { PaymentService } from "./payment.service";


@Controller('payment')
export class PaymentController {
    constructor(private readonly paymentService: PaymentService) { }

    @Post()
    @UseGuards(AuthGuard("jwt"))
    async makePayment(@Req() req: any, @Body() requestPayment: RequestPaymentDto) {
        return this.paymentService.makePayment(req.user, requestPayment);
    }

    @Post('/ipn')
    async handlePostPayment(@Body() ipnData: any) {
        return this.paymentService.handlePostPayment(ipnData)
    }
}
