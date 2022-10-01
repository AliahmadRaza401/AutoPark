import 'package:form_field_validator/form_field_validator.dart';

class TextValidator {
  static final emailValidator = [
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: "Enter valid email address")
  ];

  static final passwordValidator = [
    RequiredValidator(errorText: 'Password is required')
  ];
  static final nameValidator = [
    RequiredValidator(errorText: 'Name is required')
  ];
   static final descriptionValidator = [
    RequiredValidator(errorText: 'Description is required')
  ];
    static final phoneValidator = [
    RequiredValidator(errorText: 'Phone is required')
  ];

  
   static final priceValidator = [
    RequiredValidator(errorText: 'Price is required')
  ];
  
   static final postalValidator = [
    RequiredValidator(errorText: 'Postal Code is required')
  ];
}
