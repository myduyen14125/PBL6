import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  var cors = require('cors')

  app.use(cors())
  await app.listen(process.env.PORT);
}
bootstrap();
