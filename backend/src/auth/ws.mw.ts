import { Socket } from 'socket.io';
import { WsJwtAuthGuard } from './ws-jwt.guard';

export type SocketIOMiddleWare = {
    (client: Socket, next: (err?: Error) => void);
};

export const SocketAuthMiddleware = (): SocketIOMiddleWare => {
    return (client, next) => {
        try {
            WsJwtAuthGuard.validateToken(client)
            next();
        } catch (error) {
            next(error);
        }
    };
};