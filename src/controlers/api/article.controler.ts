import { Body, Controller, Param, Post, UploadedFile, UseInterceptors } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Crud } from "@nestjsx/crud";
import { Article } from "entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ArticleService } from "src/services/article/article.service";
import { diskStorage } from 'multer';
import { StorageConfig } from "config/storage.config";
import { fileName } from "typeorm-model-generator/dist/src/NamingStrategy";
import { Photo } from "entities/photo.entity";
import { PhotoeService } from "src/services/photo/photo.service";
import { ApiResponse } from "src/misc/api.response.class";

@Controller('api/article')
@Crud({
    model: {
        type: Article
    },
    params: {
        id: {
            field: 'articleId',
            type: 'number',
            primary: true
        }
    },
    query: {
        join: {
            category: {
                eager: true
            }, 
            photos: {
                eager: true
            },
            articlePrices: {
                eager: true
            }, 
            articleFeatures: {
                eager: true
            },
            features: {
                eager: true
            }
        }
    }
})
export class ArticleConrtoler {
    constructor(public service: ArticleService, public photoService: PhotoeService) { }

    @Post('createFull')  // http://localhost:3000/api/article/createFull/
    createFullArticle(@Body() data: AddArticleDto) {
        return this.service.createFullArticle(data);
    }

    @Post(':id/uploadPhoto/') // http://localhost:3000/api/article/:id/uploadPhoto/
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photoDestination,
                filename: (req, file, callback) => {

                    // Neka slika .jpg ->
                    // '20221015-8765867961-Neka-slika.jpg''

                    let original: string = file.originalName;

                    let normalised = original.replace(/\s+/g, '-');
                    normalised = normalised.replace(/[^A-z0-9\.\-]/g, '');
                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth() + 1).toString();
                    datePart += sada.getDate().toString();

                    let randomPart: string = 
                        new Array(10)
                        .fill(0)
                        .map(e => (Math.random() * 9).toFixed(0).toString())
                        .join('');

                    let fileName = datePart + '-' + randomPart + '-' + normalised;

                    fileName = fileName.toLowerCase();

                    callback(null, fileName);
                }
            }),

            fileFilter: (req, file, callback) => {
                // 1. check ekstenzije: jpg, png
                if (!file.originalname.match(/\.(jpg|png)$/)) {
                    callback(new Error('Bad file extension. Prvi IF'), false);
                    return;
                }

                // 2. check tipa sadrzaja: image/jpeg, image/png (mimetype)
                if (!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) {
                    callback(new Error('Bad file content. Ne valja fajl, drugi IF!'), false);
                    return;
                }

                callback (null, true);
            },
            limits: {
                files: 1,
                fieldSize: StorageConfig.photoMaxFileSize,
            }

        })
    )
    async uploadPhoto(@Param('id') articleId: number, @UploadedFile() photo): Promise <ApiResponse | Photo> {
        let imagePath = photo.filename; // u zapis u bazu podataka

        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if (!savedPhoto) {
            return new ApiResponse('error', -4001)
        }

        return savedPhoto;
    }
}