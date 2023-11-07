import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../base.repository';
import { Appointment } from './appointment.model';


@Injectable()
export class AppointmentRepository extends BaseRepository<Appointment> {
    constructor(
        @InjectModel('Appointment')
        private readonly appointmentModel: Model<Appointment>,
    ) {
        super(appointmentModel);
    }

    async countDocuments(filter) {
        return this.appointmentModel.countDocuments(filter);
    }
}