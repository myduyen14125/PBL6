import { Body, Controller, Get, Post, Query, Req, UseGuards } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { PaginationPaymentDto, RequestPaymentDto } from "./payment.dto";
import { PaymentService } from "./payment.service";
import { Role } from "src/auth/role.decorator";
import { RoleGuard } from "src/auth/role.guard";


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

    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('admin')
    @Get()
    async getPaymentLog(@Query('sort') sort: string ,@Query() { page, limit }: PaginationPaymentDto) {
        return await this.paymentService.getPaymentLog(sort, page,limit)
    }
}
