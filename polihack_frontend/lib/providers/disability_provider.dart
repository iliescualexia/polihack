import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/models/caregiver/caregiver_model.dart';
import 'package:test_project/models/caregiver/caregiver_model_mapping_extension.dart';
import 'package:test_project/models/disabilty/disabilty_model.dart';
import 'package:test_project/models/disabilty/disabilty_model_mapping_extension.dart';
import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/user/user_model.dart';
import '../models/user/user_model_mapping_extension.dart';

class DisabilityProvider with ChangeNotifier {
  DisabilityModel? _disabilityPerson;
  late CustomHttpClient _httpClient;

  DisabilityProvider() {
    _httpClient = CustomHttpClient();
  }


  DisabilityModel? get disabilityPerson {
    return _disabilityPerson;
  }

  void setDisabilityPerson(DisabilityModel disabilityPerson) {
    _disabilityPerson = disabilityPerson;
    notifyListeners();
  }

  Future<void> fetchDisabilityData(String email) async {
    try {
      final response =
      await _httpClient.get(path: '${APIConstants.disabilityUrl}/$email');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyDisability = jsonDecode(response.body);
        if (!APIResponseHandler.hasErrors(responseBodyDisability)) {
          _disabilityPerson = DisabiltyModelExtension.fromJson(
              APIResponseHandler.getData(responseBodyDisability) as Map<String, dynamic> ) ;
        } else {
          //erori trimise din back
          print("Errors:  ${APIResponseHandler.getData(responseBodyDisability)}");
        }
        notifyListeners();
      } else {
        //erori de la server
      }
    } catch (error) {
      print("Error fetching disability person: $error");
    }
  }
}
