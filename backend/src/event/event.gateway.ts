import { Injectable, Logger } from '@nestjs/common';
import { SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ServerToClientEvents } from './types/event';
import { Message } from 'src/chat/models/message.model';
import { SocketAuthMiddleware } from 'src/auth/ws.mw';
import { Chat } from 'src/chat/models/chat.model';

@WebSocketGateway({ namespace: 'event' })
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

  seenStatus(chat: Chat) {
    this.server.emit('seenStatus', chat)
  }
}