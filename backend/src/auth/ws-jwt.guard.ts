import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { verify } from 'jsonwebtoken';
import { Socket } from 'socket.io';

@Injectable()
export class WsJwtAuthGuard implements CanActivate {


    canActivate(context: ExecutionContext): any {
        if (context.getType() !== 'ws') {
            return true;
        }

        const client: Socket = context.switchToWs().getClient();
        WsJwtAuthGuard.validateToken(client)
        return true;
    }

    static validateToken(client: Socket) {
        const { authorization } = client.handshake.headers;
        const token: string = authorization.split(' ')[1];
        const payload = verify(token, 'phvntiendat')
        return payload
    }
}
