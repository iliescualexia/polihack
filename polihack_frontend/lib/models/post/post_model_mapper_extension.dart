import 'package:test_project/models/post/post_model.dart';
import 'package:test_project/models/user/user_model.dart';

extension PostModelExtension on PostModel {
  // Convert UserModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'category': category,
      'description': description,
      'postType': postType,
      'hourlyWage':hourlyWage
    };
  }

  // Convert Map to a UserModel object
  static PostModel fromJson(Map<String, dynamic> json) {
    PostModel post = PostModel();
    post.email = json['email'];
    post.category = json['category'];
    post.description = json['description'];
    post.postType = json['postType'];
    post.postIdentifier = json['postIdentifier'];
    post.hourlyWage=json['hourlyWage'];
    return post;
  }
}
