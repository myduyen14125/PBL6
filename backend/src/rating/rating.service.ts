import { Inject, Injectable, NotFoundException, forwardRef } from "@nestjs/common";
import { AppointmentService } from "src/appointment/appointment.service";
import { User } from "src/user/user.model";
import { CreateRatingDto } from "./rating.dto";
import { RatingRepository } from "./rating.repository";

@Injectable()
export class RatingService {
    constructor(
        private readonly ratingRepository: RatingRepository,
        @Inject(forwardRef(() => AppointmentService)) private readonly appointmentService: AppointmentService
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
        rating.mentor = checkAppointment.mentor._id
        const newRating = await this.ratingRepository.create(rating)

        return newRating.populate({ path: 'mentee', select: 'name avatar email role' });

    }
    ///////////////////////////////////////
    async getAllRatingsByUserId(id: string, page: number, limit: number = 10) {
        const count = await this.ratingRepository.countDocuments({
            mentor: id
        },)
        const countPage = Math.ceil(count / limit)

        const ratings = await this.ratingRepository.getByCondition({
            mentor: id
        },
            null,
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'mentee', select: 'name avatar email role' })
        return { count, countPage, ratings }
    }

}

