import { HttpStatus, Injectable, NotFoundException, forwardRef, Inject } from "@nestjs/common";
import { User } from "src/user/models/user.model";
import { CreateRatingDto } from "../dto/rating.dto";
import { RatingRepository } from "../repositories/rating.repository";
import { AppointmentService } from "src/appointment/services/appointment.service";

@Injectable()
export class RatingService {
    constructor(
        private readonly ratingRepository: RatingRepository,
        private readonly appointmentService: AppointmentService
    ) { }



    async createRating(user: User, rating: CreateRatingDto) {

        // access #0.5 - check if rating with appointment id already existed
        const ratings = await this.ratingRepository.getByCondition(
            {
                appointment: rating.appointment
            }
        )
        const numberOfRatings = ratings.length;
        console.log(numberOfRatings);

        if (numberOfRatings >= 1) return new NotFoundException("Existed rating linked to that appointment id.");


        // access #1 - participants that is mentee only
        const checkAppointment = await this.appointmentService.getAppointmentById(user, rating.appointment)

        // fix reponse http res
        if (!checkAppointment) {
            return new NotFoundException("Mentor with the provided ID does not exist.");
        }

        // access #2 - mentee only

        if (!checkAppointment.mentee.equals(user._id)) {
            return new NotFoundException("Only participated mentee can give rating.");
        }

        // access #3 - appointment status is 'finished'
        if (checkAppointment.status !== 'finished') return new NotFoundException("Rating's not available until appointment is finished.");

        // update appointment status to rated

        await this.appointmentService.updateRatedAppointment(checkAppointment._id, "rated")

        // create rating
        rating.mentee = user._id
        const newRating = await this.ratingRepository.create(rating)

        return newRating.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });

    }
    ///////////////////////////////////////
    async getAllRatingsByUserId(id: string) {
        return await this.ratingRepository.getByCondition({
            mentor: id
        })
    }

}

// UserService uses its repository and BlogService, ScheduleService, RatingService
// BlogService uses its repository
// AppointmentService uses  its repository and UserService and ScheduleService
// RatingService uses its repository AppointmentService
// ScheduleService uses its repository