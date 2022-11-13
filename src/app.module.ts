import { applyDecorators, MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './controlers/app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseCofiguration } from 'config/database.configuration';
import { Administrator } from 'entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { ArticleFeature } from 'entities/article-feature.entity';
import { ArticlePrice } from 'entities/article-price.entity';
import { Article } from 'entities/article.entity';
import { CartArticle } from 'entities/cart-article.entity';
import { Cart } from 'entities/cart.entity';
import { Category } from 'entities/category.entity';
import { Feature } from 'entities/feature.entity';
import { Order } from 'entities/order.entity';
import { Photo } from 'entities/photo.entity';
import { User } from 'entities/user.entity';
import { AdministratorController } from './controlers/api/administrator.controler';
import { CategoryConrtoler } from './controlers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { ArticleService } from './services/article/article.service';
import { ArticleConrtoler } from './controlers/api/article.controler';
import { authConotroller } from './controlers/api/auth.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { PhotoeService } from './services/photo/photo.service';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseCofiguration.hostname,
      port: 3306, 
      username: DatabaseCofiguration.username,
      password: DatabaseCofiguration.password,
      database: DatabaseCofiguration.database,
      entities:[
        Administrator,
        ArticleFeature,
        ArticlePrice,
        Article,
        CartArticle,
        Cart,
        Category, 
        Feature,
        Order,
        Photo,
        User
      ]
    }),
    TypeOrmModule.forFeature([ 
      Administrator,
        ArticleFeature,
        ArticlePrice,
        Article,
        CartArticle,
        Cart,
        Category, 
        Feature,
        Order,
        Photo,
        User
    ])
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryConrtoler,
    ArticleConrtoler,
    authConotroller,
  ],
  providers: [
    AdministratorService, 
    CategoryService,
    ArticleService,
    PhotoeService,
  ],
  exports: [
    AdministratorService
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
    .apply(AuthMiddleware)
    .exclude('auth/*')
    .forRoutes('api/*')
  }
}