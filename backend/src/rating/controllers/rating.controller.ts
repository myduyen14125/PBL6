import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { RatingService } from '../services/rating.service';
import { CreateRatingDto } from '../dto/rating.dto';


@Controller('rating')
export class RatingController {
    constructor(private readonly ratingService: RatingService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createRating(@Req() req: any, @Body(new ValidationPipe()) rating: CreateRatingDto) {

        return this.ratingService.createRating(req.user, rating);
    }



}
