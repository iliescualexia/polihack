import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/models/caregiver/caregiver_model.dart';
import 'package:test_project/models/caregiver/caregiver_model_mapping_extension.dart';
import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/user/user_model.dart';
import '../models/user/user_model_mapping_extension.dart';

class CaregiverProvider with ChangeNotifier {
  CaregiverModel? _caregiver;
  late CustomHttpClient _httpClient;

  CaregiverProvider() {
    _httpClient = CustomHttpClient();
  }


  CaregiverModel? get caregiver {
    return _caregiver;
  }

  void setCaregiver(CaregiverModel caregiver) {
    _caregiver = caregiver;
    notifyListeners();
  }

  Future<void> fetchCaregiverData(String email) async {
    try {
      final response =
      await _httpClient.get(path: '${APIConstants.caregiverUrl}/$email');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyCaregiver = jsonDecode(response.body);
        if (!APIResponseHandler.hasErrors(responseBodyCaregiver)) {
          _caregiver = CaregiverModelExtension.fromJson(
              APIResponseHandler.getData(responseBodyCaregiver) as Map<String, dynamic> ) ;
        } else {
          //erori trimise din back
          print("Errors:  ${APIResponseHandler.getData(responseBodyCaregiver)}");
        }
        notifyListeners();
      } else {
        //erori de la server
      }
    } catch (error) {
      print("Error fetching caregiver: $error");
    }
  }
}
