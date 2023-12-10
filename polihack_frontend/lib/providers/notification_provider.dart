import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/models/notification/notification_model.dart';
import 'package:test_project/models/post/post_model_mapper_extension.dart';
import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/notification/notification_model_mapper_extension.dart';
import '../models/post/post_model.dart';
import '../models/user/user_model.dart';
import '../models/user/user_model_mapping_extension.dart';

class NotificationProvider with ChangeNotifier {
  late List<NotificationModel> _notifications=[];
  late CustomHttpClient _httpClient;

  NotificationProvider() {
    _httpClient = CustomHttpClient();
  }

  List<NotificationModel> get notifications => _notifications;


  Future<void> fetchNotifications(String email) async {
    try {
      String url ='${APIConstants.notificationUrl}/findAllNotificationForUser/$email';
      print(url);
      final response =
      await _httpClient.get(path: '${APIConstants.notificationUrl}/findAllNotificationForUser/$email');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyNotification = jsonDecode(response.body);
        if (!APIResponseHandler.hasErrors(responseBodyNotification)) {
          _notifications.clear();
          List<NotificationModel> fetchedNotifications = (APIResponseHandler.getData(responseBodyNotification) as List<dynamic>)
              .map<NotificationModel>((nData) =>NotificationModelExtension.fromJson(nData as Map<String,dynamic>))
              .toList();
          _notifications = fetchedNotifications;
        } else {
          //erori trimise din back
          print("Errors:  ${APIResponseHandler.getData(responseBodyNotification)}");
        }
        notifyListeners();
      } else {
        //erori de la server
      }
    } catch (error) {
      print("Error fetching notifications: $error");
    }
  }
}
