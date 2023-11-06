import { Module } from '@nestjs/common';
import { PaymentController } from './controllers/payment.controller';
import { PaymentService } from './services/payment.service';

@Module({
    imports: [

    ],

    controllers: [PaymentController],
    providers: [PaymentService],
    exports: [PaymentService]
})
export class PaymentModule { }
