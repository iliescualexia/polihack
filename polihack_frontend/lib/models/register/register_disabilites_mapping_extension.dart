import 'package:test_project/models/register/register_disabilities_credential_model.dart';

extension RegisterMappingExtension on RegisterCredentialsModel {

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'city': city,
      'country': country,
      'role': role,
      'county': county,
      'description':description,
      'categories': categories,
      'status':status
    };
  }
}
