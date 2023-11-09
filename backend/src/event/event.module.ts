import { Module, forwardRef } from '@nestjs/common';
import { EventGateway } from './event.gateway';
import { ConfigService } from '@nestjs/config';
import { ChatModule } from 'src/chat/chat.module';
import { UserModule } from 'src/user/user.module';

@Module({
  imports: [
    forwardRef(() => ChatModule),
    forwardRef(() => UserModule),
  ],
  providers: [EventGateway, ConfigService],
  exports: [EventGateway]
})
export class EventModule { }
