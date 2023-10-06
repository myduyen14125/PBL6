import { Body, Controller, Post, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { CreateUserDto, LoginUserDto } from 'src/user/dto/user.dto';
import { AuthService } from '../services/auth.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) { }

    @Post('register')
    async register(@Body(new ValidationPipe()) createUserDto: CreateUserDto) {
        return await this.authService.register(createUserDto);
    }

    @Post('login')
    async login(@Body() loginUserDto: LoginUserDto) {
        return await this.authService.login(loginUserDto);
    }

    @UseGuards(AuthGuard("jwt"))
    @Post('logout')
    async logout(@Req() req: any) {
        return await this.authService.logout(req.user)
    }

}