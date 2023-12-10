import 'package:test_project/models/register/register_caregiver_credential_model.dart';
import 'package:test_project/models/register/register_disabilities_credential_model.dart';

extension RegisterCaregiverMappingExtension on RegisterCaregiverCredentialsModel {

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
      'description': description,
      'status': status,  // Assuming 'status' is a field in your model
      'hourlyWage': hourlyWage,  // Add the 'hourlyWage' field
    };
  }
}
