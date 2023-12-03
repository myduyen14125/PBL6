import {ValidationOptions, registerDecorator, ValidatorConstraint, ValidatorConstraintInterface, ValidationArguments} from 'class-validator';
  
  @ValidatorConstraint({ async: false })
  export class PasswordStrengthConstraint implements ValidatorConstraintInterface {
    validate(password: string): boolean {
      const regex = /^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[A-Z]).+$/;
      return regex.test(password);
    }
  
    defaultMessage(args: ValidationArguments) {
      return 'Password must contain at least 1 special character and 1 capital letter';
    }
  }
  
  export function IsStrongPassword(validationOptions?: ValidationOptions) {
    return function (object: Object, propertyName: string) {
      registerDecorator({
        target: object.constructor,
        propertyName: propertyName,
        options: validationOptions,
        constraints: [],
        validator: PasswordStrengthConstraint,
      });
    };
  }
  