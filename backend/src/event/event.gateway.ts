import { Injectable, Logger, UseGuards } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import {
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ServerToClientEvents } from './types/event';
import { Message } from 'src/chat/models/message.model';
import { WsJwtAuthGuard } from 'src/auth/ws-jwt.guard';
import { SocketAuthMiddleware } from 'src/auth/ws.mw';

@WebSocketGateway({ namespace: 'event' })
// @UseGuards(WsJwtAuthGuard)
@Injectable()
export class EventGateway {

  @WebSocketServer()
  server: Server<any, ServerToClientEvents>;

  afterInit(client: Socket) {
    client.use(SocketAuthMiddleware() as any)
    Logger.log('afterinit')
  }

  @SubscribeMessage('message')
  handleMessage(client: any, payload: any): string {
    return 'Hello world!'
  }

  sendNewMessage(message: Message) {
    this.server.emit('newMessage', message)
  }
}