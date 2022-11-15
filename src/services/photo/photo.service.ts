import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Photo } from "src/entities/photo.entity";
import { Repository } from "typeorm";

@Injectable()
export class PhotoeService extends TypeOrmCrudService<Photo> {
    constructor( 
        @InjectRepository(Photo) private readonly photo: Repository<Photo>  // cim uvedemo neki category moramo da ga navedemo u app modulu

    ) {
        super(photo);
    }

    add(newPhoto: Photo): Promise<Photo> {
        return this.photo.save(newPhoto);
    }
}