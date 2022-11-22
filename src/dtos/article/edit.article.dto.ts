export class EditArticleDto {
    name: string;
    categoryId: number;
    excert: string;
    decription: string;
    status: 'visible' | 'avaliable' | 'hiden';
    isPromoted: 0 | 1;
    price: number;
    features: {
        featureId: number;
        value: string;
    }[] | null;
}