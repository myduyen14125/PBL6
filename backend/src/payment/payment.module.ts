import { Module, forwardRef } from '@nestjs/common';
import { CourseModule } from 'src/course/course.module';
import { PaymentController } from './payment.controller';
import { PaymentService } from './payment.service';
import { MongooseModule } from '@nestjs/mongoose';
import { PaymentSchema } from './payment.model';
import { PaymentRepository } from './payment.repository';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Payment',
                schema: PaymentSchema
            }
        ]),
        forwardRef(() => CourseModule)
    ],

    controllers: [PaymentController],
    providers: [PaymentService, PaymentRepository],
    exports: [PaymentService]
})
export class PaymentModule { }
