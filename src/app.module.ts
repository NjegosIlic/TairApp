import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseCofiguration } from 'config/database.configuration';
import { Administrator } from 'entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseCofiguration.hostname,
      port: 3306, 
      username: DatabaseCofiguration.username,
      password: DatabaseCofiguration.password,
      database: DatabaseCofiguration.database,
      entities:[ Administrator ]
    }),
    TypeOrmModule.forFeature([ Administrator ])
  ],
  controllers: [AppController],
  providers: [AdministratorService],
})
export class AppModule {}
