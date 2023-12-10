import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/models/post/post_model_mapper_extension.dart';
import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/post/post_model.dart';
import '../models/user/user_model.dart';
import '../models/user/user_model_mapping_extension.dart';

class PostProvider with ChangeNotifier {
  late List<PostModel> _posts=[];
  late CustomHttpClient _httpClient;

  PostProvider() {
    _httpClient = CustomHttpClient();
  }

  List<PostModel> get posts => _posts;


  Future<void> fetchPosts(String email) async {
    try {
      final response =
      await _httpClient.get(path: '${APIConstants.postUrl}/findAll');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyPosts = jsonDecode(response.body);
        print(responseBodyPosts);
        if (!APIResponseHandler.hasErrors(responseBodyPosts)) {
          _posts.clear();
          List<PostModel> fetchedPosts = (APIResponseHandler.getData(responseBodyPosts) as List<dynamic>)
              .map<PostModel>((postData) =>PostModelExtension.fromJson(postData as Map<String,dynamic>))
              .toList();
          _posts = fetchedPosts;
        } else {
          //erori trimise din back
          print("Errors:  ${APIResponseHandler.getData(responseBodyPosts)}");
        }
        notifyListeners();
      } else {
        //erori de la server
      }
    } catch (error) {
      print("Error fetching post: $error");
    }
  }
}
