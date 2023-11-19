import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from 'src/base.repository';
import { Payment } from './payment.model';


@Injectable()
export class PaymentRepository extends BaseRepository<Payment> {
    constructor(
        @InjectModel('Payment')
        private readonly paymentModel: Model<Payment>,
    ) {
        super(paymentModel);
    }

    async countDocuments(filter) {
        return this.paymentModel.countDocuments(filter);
    }
}