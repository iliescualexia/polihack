import 'package:test_project/models/caregiver/caregiver_model.dart';
import 'package:test_project/models/user/user_model.dart';

extension CaregiverModelExtension on CaregiverModel {
  // Convert UserModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'description': description,
      'hourlyWage': hourlyWage,
    };
  }

  // Convert Map to a UserModel object
  static CaregiverModel fromJson(Map<String, dynamic> json) {
    CaregiverModel caregiverModel = CaregiverModel();
    caregiverModel.email = json['email'];
    caregiverModel.description = json['description'];
    caregiverModel.hourlyWage = json['hourlyWage'];
    return caregiverModel;
  }
}
