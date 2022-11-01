import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Category } from "entities/category.entity";
import { Repository } from "typeorm";


@Injectable()
export class CategoryService extends TypeOrmCrudService<Category> {
    constructor( 
        @InjectRepository(Category) private readonly category: Repository<Category> // cim uvedemo neki category moramo da ga navedemo u app modulu
    ) {
        super(category);
    }
}