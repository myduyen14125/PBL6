import { SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets';
import { Server } from 'socket.io';
import { ServerToClientEvents } from './types/event';
import { Message } from 'src/chat/models/message.model';

@WebSocketGateway()
export class EventGateway {

  @WebSocketServer()
  server: Server<any, ServerToClientEvents>;

  @SubscribeMessage('message')
  handleMessage(client: any, payload: any): string {
    return 'Hello world!';
  }


  ////////////////////////

  sendMessage(message: Message) {
    this.server.emit('newMessage', message)
  }

}
