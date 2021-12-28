import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    // origin: ['http://localhost:3000'],
    origin: [
      'https://associate-nicole-acne-income.trycloudflare.com',
      'https://resource-pwa.web.app',
      'http://localhost:3000',
      'http://localhost:5001',
      'http://10.0.0.160:3000',
      'http://10.0.0.160:5001',
    ],
  });
  await app.listen(5000);
}
bootstrap();
