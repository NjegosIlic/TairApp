export class AddArticleDto {
    name: string;
    categoryId: number;
    excert: string;
    decription: string;
    price: number;
    features: {
        featureId: number;
        value: string;
    }[];
}