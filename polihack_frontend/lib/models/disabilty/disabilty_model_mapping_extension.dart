import 'package:test_project/models/caregiver/caregiver_model.dart';
import 'package:test_project/models/disabilty/disabilty_model.dart';
import 'package:test_project/models/user/user_model.dart';

extension DisabiltyModelExtension on DisabilityModel {
  // Convert UserModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'description': description,
      'categories': categories,
    };
  }

  // Convert Map to a UserModel object
  static DisabilityModel fromJson(Map<String, dynamic> json) {
    DisabilityModel disabilityModel = DisabilityModel();
    disabilityModel.email = json['email'];
    disabilityModel.description = json['description'];
    disabilityModel.categories = json['categories'];
    return disabilityModel;
  }
}
