import 'package:test_project/models/caregiver/caregiver_model.dart';
import 'package:test_project/models/user/user_model.dart';

import 'notification_model.dart';

extension NotificationModelExtension on NotificationModel {
  // Convert UserModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'receiverEmail': receiverEmail,
      'senderEmail': senderEmail,
    };
  }

  // Convert Map to a UserModel object
  static NotificationModel fromJson(Map<String, dynamic> json) {
    NotificationModel notificationModel = NotificationModel();
    notificationModel.receiverEmail = json['receiverEmail'];
    notificationModel.senderEmail = json['senderEmail'];
    notificationModel.notificationIdentifier = json['notificationIdentifier'];
    return notificationModel;
  }
}
