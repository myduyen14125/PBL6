import { Body, Controller, Get, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateRatingDto, PaginationRatingDto } from './rating.dto';
import { RatingService } from './rating.service';


@Controller('rating')
export class RatingController {
    constructor(private readonly ratingService: RatingService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createRating(@Req() req: any, @Body(new ValidationPipe()) rating: CreateRatingDto) {

        return this.ratingService.createRating(req.user, rating);
    }

    @Get()
    @UseGuards(AuthGuard('jwt'))
    async getAllRatingsByUserId(@Req() req: any, @Query() { page, limit }: PaginationRatingDto) {

        return this.ratingService.getAllRatingsByUserId(req.user._id, page, limit);
    }




}
