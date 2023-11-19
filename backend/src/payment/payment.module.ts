import { Module, forwardRef } from '@nestjs/common';
import { PaymentController } from './payment.controller';
import { PaymentService } from './payment.service';
import { CourseModule } from 'src/course/course.module';
import { PaymentRepository } from './payment.repository';
import { MongooseModule } from '@nestjs/mongoose';
import { PaymentSchema } from './payment.model';

@Module({
    imports: [
        // MongooseModule.forFeature([
        //     {
        //         name: 'Payment',
        //         schema: PaymentSchema
        //     }
        // ]),
        forwardRef(() => CourseModule)
    ],

    controllers: [PaymentController],
    providers: [PaymentService],
    exports: [PaymentService]
})
export class PaymentModule { }
