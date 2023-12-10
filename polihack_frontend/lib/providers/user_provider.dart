import 'dart:convert';

import 'package:flutter/material.dart';
import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/user/user_model.dart';
import '../models/user/user_model_mapping_extension.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  late CustomHttpClient _httpClient;

  UserProvider() {
    _httpClient = CustomHttpClient();
  }

  bool get isLoggedIn => _user != null;

  UserModel? get user {
    return _user;
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchUserData(String email) async {
    try {
      final response =
      await _httpClient.get(path: '${APIConstants.userUrl}/$email');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyUser = jsonDecode(response.body);
        if (!APIResponseHandler.hasErrors(responseBodyUser)) {
          _user = UserMappingExtension.fromJson(
              APIResponseHandler.getData(responseBodyUser) as Map<String, dynamic> ) ;
        } else {
          //erori trimise din back
          print("Errors:  ${APIResponseHandler.getData(responseBodyUser)}");
        }
        notifyListeners();
      } else {
        //erori de la server
      }
    } catch (error) {
      print("Error fetching user: $error");
    }
  }
}
