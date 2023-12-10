import 'package:test_project/models/user/user_model.dart';

extension UserMappingExtension on UserModel {
  // Convert UserModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'status': status,
      'country': country,
      'county': county,
      'city': city,
    };
  }

  // Convert Map to a UserModel object
  static UserModel fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel();
    user.email = json['email'];
    user.firstName = json['firstName'];
    user.lastName = json['lastName'];
    user.role = json['role'];
    user.status = json['status'];
    user.county = json['county'];
    user.country = json['country'];
    user.city = json['city'];
    return user;
  }
}
