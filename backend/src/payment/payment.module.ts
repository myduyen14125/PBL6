import { Module, forwardRef } from '@nestjs/common';
import { CourseModule } from 'src/course/course.module';
import { PaymentController } from './payment.controller';
import { PaymentService } from './payment.service';

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
