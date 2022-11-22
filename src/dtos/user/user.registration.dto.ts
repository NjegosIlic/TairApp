import * as Validator from 'class-validator';

export class UserRegistrationDto {
   
    email: string;
    password: string;
    forename: string;
    surname: string;
    phoneNumber: string;
    postalAddress: string;
}