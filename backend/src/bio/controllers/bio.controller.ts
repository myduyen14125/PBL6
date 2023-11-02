import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { BioService } from '../services/bio.service';

@Controller('bio')
export class BioController {
    constructor(private readonly bioService: BioService) { }

    @Get()
    @UseGuards(AuthGuard('jwt'))
    async getUserBio(@Req() req: any) {
        return this.bioService.getUserBio(req.user.id);
    }
}
