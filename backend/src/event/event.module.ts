import { Module } from '@nestjs/common';
import { EventGateway } from './event.gateway';
import { ConfigService } from '@nestjs/config';

@Module({
  providers: [EventGateway, ConfigService],
  exports: [EventGateway]
})
export class EventModule { }
