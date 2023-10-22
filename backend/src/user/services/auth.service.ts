import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { UserService } from "./user.service";
import { JwtService } from "@nestjs/jwt";
import { CreateUserDto, LoginUserDto } from "../dto/user.dto";
import { User } from "../models/user.model";

@Injectable()
export class AuthService {
    constructor(
        private readonly userService: UserService,
        private readonly jwtService: JwtService
    ) { }

    async register(userDto: CreateUserDto) {
        if (userDto.role === "mentor") {
            userDto.number_of_mentees = 0;
        }
        const user = await this.userService.createUser(userDto);
        const userObject = user.toObject ? user.toObject() : user;
        delete userObject.refreshToken;

        const token = await this._createToken(user);

        const response = {
            ...userObject,
            expiresIn: token.expiresIn,
            accessToken: token.accessToken,
            refreshToken: token.refreshToken,
        };

        return response;
    }

    async login(loginUserDto: LoginUserDto) {
        const user = await this.userService.login(loginUserDto);
        const userObject = user.toObject ? user.toObject() : user;
        delete userObject.refreshToken;

        const token = await this._createToken(user);

        const response = {
            ...userObject,
            expiresIn: token.expiresIn,
            accessToken: token.accessToken,
            refreshToken: token.refreshToken,
        };

        return response;
    }

    private async _createToken({ email }) {
        const accessToken = this.jwtService.sign({ email })
        const refreshToken = this.jwtService.sign(
            { email },
            {
                secret: process.env.SECRETKEY_REFRESH,
                expiresIn: process.env.EXPIRESIN_REFRESH
            })
        await this.userService.updateUser(
            { email: email },
            { refreshToken: refreshToken },
        );
        return {
            expiresIn: process.env.EXPIRESIN,
            accessToken,
            refreshToken
        };
    }

    async handleVerifyToken(token) {
        try {
            const payload = this.jwtService.verify(token);
            return payload['email'];
        } catch (e) {
            throw new HttpException(
                {
                    key: '',
                    data: {},
                    statusCode: HttpStatus.UNAUTHORIZED,
                },
                HttpStatus.UNAUTHORIZED,
            );
        }
    }

    async logout(user: User) {
        await this.userService.updateUser(
            { email: user.email },
            { refreshToken: null },
        );
    }

    async validateUser(email) {
        const user = await this.userService.findByEmail(email);
        if (!user) {
            throw new HttpException('Invalid token', HttpStatus.UNAUTHORIZED);
        }
        return user;
    }

    async refresh(refresh_token) {
        try {
            const payload = await this.jwtService.verify(refresh_token, {
                secret: process.env.SECRETKEY_REFRESH,
            });
            const user = await this.userService.getUserByRefresh(
                refresh_token,
                payload.email,
            );
            const token = await this._createToken(user);
            return {
                email: user.email,
                ...token,
            };
        } catch (e) {
            throw new HttpException('Invalid token', HttpStatus.UNAUTHORIZED);
        }
    }
}