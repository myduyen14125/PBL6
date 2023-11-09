import { Inject, Injectable, Logger, UseGuards, forwardRef } from '@nestjs/common';
import { SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ServerToClientEvents } from './types/event';
import { Message } from 'src/chat/models/message.model';
import { SocketAuthMiddleware } from 'src/auth/ws.mw';
import { Chat } from 'src/chat/models/chat.model';
import { WsJwtAuthGuard } from 'src/auth/ws-jwt.guard';
import { UserService } from 'src/user/user.service';
import { ChatService } from 'src/chat/services/chat.service';

@WebSocketGateway({ cors: true })
@UseGuards(WsJwtAuthGuard)
@Injectable()
export class EventGateway {
  constructor(
    @Inject(forwardRef(() => UserService)) private readonly userService: UserService,
    @Inject(forwardRef(() => ChatService)) private readonly chatService: ChatService,
  ) { }

  @WebSocketServer()
  server: Server<any, ServerToClientEvents>;

  afterInit(client: Socket) {
    client.use(SocketAuthMiddleware() as any);
    Logger.log("-------------------------socket server initiated-------------------------")
  }


  @SubscribeMessage('message')
  handleMessage(client: any, payload: any): string {

    return 'Hello world!'
  }

  @SubscribeMessage('room')
  async joinRoom(client: Socket) {
    // get email from token
    const payload = WsJwtAuthGuard.validateToken(client);
    var email = ''
    if (typeof payload === 'object' && payload !== null) {
      email = payload.email;
    }

    // get user from email
    const user = await this.userService.findByEmail(email)
    // console.log(user);

    // get room (all chatId) from user
    const rooms = await this.chatService.getUserChats(user)
    rooms.map((room) => {
      client.join(room.id.toString());
    })

    console.log(client.rooms);
    this.server.emit('joinStatus', "Joined")

  }

  sendNewMessage(message: Message) {
    console.log(message.chat._id.toString());

    this.server.to(message.chat._id.toString()).emit('newMessage', message)
  }

  seenStatus(chat: Chat) {
    this.server.emit('seenStatus', chat)
  }
}
