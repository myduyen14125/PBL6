import { Body, Controller, Get, Param, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
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
    async getCurrentUsersRatings(@Req() req: any, @Query() { page, limit }: PaginationRatingDto) {

        return this.ratingService.getAllRatingsByUserId(req.user._id, page, limit);
    }

    @Get('by-user/:id')
    getAllRatingsByUserId(@Param('id') id: string, @Query() { page, limit }: PaginationRatingDto) {
        return this.ratingService.getAllRatingsByUserId(id, page, limit);
    }


}
