import { HttpStatus, Injectable, NotFoundException } from "@nestjs/common";
import { AppointmentRepository } from "src/appointment/repositories/appointment.repository";
import { User } from "src/user/models/user.model";
import { UserRepository } from "src/user/repositories/user.repository";
import { CreateRatingDto } from "../dto/rating.dto";
import { RatingRepository } from "../repositories/rating.repository";

@Injectable()
export class RatingService {
    constructor(private readonly ratingRepository: RatingRepository,
        private readonly userRepository: UserRepository,
        private readonly appointmentRepository: AppointmentRepository
    ) { }

    async checkMentee(mentee_id: string) {
        const mentor = await this.userRepository.findById(mentee_id);
        if (mentor && mentor.role == "mentee") {
            return true
        }
        return false
    }

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
        const checkAppointment = await this.appointmentRepository.findById(
            rating.appointment
        )

        console.log(checkAppointment.status);
        console.log(user._id);

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

        await this.appointmentRepository.findByIdAndUpdate(checkAppointment._id, {
            status: "rated"
        })

        // create rating
        rating.mentee = user._id
        const newRating = await this.ratingRepository.create(rating)

        return newRating.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });





    }

}