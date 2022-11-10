import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { ArticleFeature } from "entities/article-feature.entity";
import { ArticlePrice } from "entities/article-price.entity";
import { Article } from "entities/article.entity";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";


@Injectable()
export class ArticleService extends TypeOrmCrudService<Article> {
    constructor( 
        @InjectRepository(Article) private readonly article: Repository<Article>,  // cim uvedemo neki category moramo da ga navedemo u app modulu

        @InjectRepository(ArticlePrice) private readonly articlePrice: Repository<ArticlePrice>,

        @InjectRepository(ArticleFeature) private readonly articleFeature: Repository<ArticleFeature>,
    ) {
        super(article);
    }

    async createFullArticle(data: AddArticleDto): Promise<Article | ApiResponse> {
        let newArticle: Article = new Article();
        newArticle.name = data.name;
        newArticle.categoryId = data.categoryId;
        newArticle.excerpt = data.excert;
        newArticle.description = data.decription;

        let savedArticle = await this.article.save(newArticle);

        let newArticlePrice: ArticlePrice = new ArticlePrice();
        newArticlePrice.articleId = savedArticle.articleId;
        newArticlePrice.price = data.price;

        await this.articlePrice.save(newArticlePrice);

        for (let feature of data.features) {
            let newArticleFeature: ArticleFeature = new ArticleFeature();
            newArticleFeature.articleId = savedArticle.articleId;
            newArticleFeature.featureId = feature.featureId;
            newArticleFeature.value = feature.value;

            await this.articleFeature.save(newArticleFeature);
        }

        return await this.article.findOne({where: {articleId: savedArticle.articleId},
            relations: {
                category: true,
                articleFeatures: true,
                features: true,
                articlePrices: true
            }}
        );    

    }

}