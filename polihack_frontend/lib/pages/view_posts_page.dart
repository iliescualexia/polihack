import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/notification/notification_model.dart';
import 'package:test_project/models/notification/notification_model_mapper_extension.dart';
import 'package:test_project/pages/main_menu_page.dart';
import 'package:test_project/providers/post_provider.dart';
import 'package:test_project/utils/app_text_style.dart';
import 'package:test_project/widgets/text_button_four.dart';
import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/post/post_model.dart';
import '../providers/user_provider.dart';
import '../utils/app_gradient.dart';
import '../utils/app_colors.dart';
import '../widgets/text_button_three.dart';

class Post {
  final String profilePicture;
  final String fullName;
  final String category;
  final double price;

  Post({
    required this.profilePicture,
    required this.fullName,
    required this.category,
    required this.price,
  });
}

class ViewPostsPage extends StatefulWidget {
  const ViewPostsPage({Key? key}) : super(key: key);

  @override
  State<ViewPostsPage> createState() => _ViewPostsPageState();
}

class _ViewPostsPageState extends State<ViewPostsPage> {

  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = context.watch<PostProvider>();
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      appBar: AppBar(
        backgroundColor: AppColors.deepPurple,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.paleGrey,
            size: 30,
          ),
          onPressed: () {
            // Add your arrow button onPressed logic here
            Navigator.pop(
                context
            );
            print('Arrow button pressed!');
          },
        ),
        title: Text('Post List'),
      ),
      body: ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          return buildPostCard(context, postProvider.posts[index]);
        },
      ),
    );
  }

  Widget buildPostCard(BuildContext context, PostModel post) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0, // Set the elevation for a shadow effect if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Set border radius
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppGradient.backgroundGradient(), // Set your desired background color
          borderRadius: BorderRadius.circular(12.0), // Match the border radius
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/id/433/200/300'),

          ),
          title: Text(post.email),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category: ${post.category}'),
              Text('Price (lei/h): ${post.hourlyWage.toString()}'),
            ],
          ),
          trailing: TextButtonFour(
            onPressed: () {
              _contactButtonPressed(context, post);
            },
            text: 'Contact',
          ),
        ),
      ),
    );
  }


  void _contactButtonPressed(BuildContext context, PostModel post) {
    // Replace this with your contact logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact ${post.email}'),
          content: Text(post.description, style: AppTextStyle.darkDefaultStyle(),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red,fontSize: 16),),
            ),
            TextButton(
              onPressed: () {
                _contact(post);
                Navigator.of(context).pop();
              },
              child: Text('Request help',style: AppTextStyle.darkDefaultStyle(),),
            ),
          ],
        );
      },
    );
  }
  Future<String?> _contact( PostModel post) async{
    CustomHttpClient httpClient = CustomHttpClient();

    final Map<String, String> headers = {
      'Content-Type':'application/json',
    };
    final UserProvider userProvider = context.read<UserProvider>();
    NotificationModel notificationModel = NotificationModel();
    notificationModel.receiverEmail = post.email;
    notificationModel.senderEmail = userProvider.user!.email;
    String body = jsonEncode(notificationModel.toJson());
    print(body);
    final response = await httpClient.post(path: '${APIConstants.notificationUrl}/save', headers: headers, body: body);
    if(response.statusCode == 200){
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if(!APIResponseHandler.hasErrors(responseBody)){
        print("Request successful");
      }
      else{
        return APIResponseHandler.getData(responseBody);
      }
    }
    else{
      return "Internal server error. Please try again.";
    }
  }
}