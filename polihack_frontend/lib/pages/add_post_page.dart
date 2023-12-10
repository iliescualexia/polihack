import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/post/post_model.dart';
import 'package:test_project/models/post/post_model_mapper_extension.dart';
import 'package:test_project/pages/main_menu_page.dart';
import 'package:test_project/utils/app_colors.dart';
import 'package:test_project/utils/app_text_style.dart';

import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../providers/user_provider.dart';
import '../widgets/snack_bar_custom.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String selectedValue = 'Hearing deficiency'; // Default selected value
  int price = 0;
  String description = "";
  PostModel postModel = PostModel();
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  String email="";
  @override
  void initState(){
    priceController = TextEditingController(text: postModel.hourlyWage.toString());
    descriptionController = TextEditingController(text: postModel.description);

    priceController.addListener(() {
      postModel.hourlyWage = int.parse(priceController.text);
    });

    descriptionController.addListener(() {
      postModel.description = descriptionController.text;
    });

  }
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    email = userProvider.user!.email;
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
            Navigator.pop(
                context
            );;
            // Add your arrow button onPressed logic here
            print('Arrow button pressed!');
          },
        ),
        title: Text(
          'Create Post',
          style: AppTextStyle.focusedLightStyle(),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: AppColors.deepPurple,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                color: Color(0x36000000),
                                offset: Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity, // Set width to match other containers
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/id/237/200/100',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                  child: Text(
                                    userProvider.user!.firstName + " " + userProvider.user!.lastName,
                                    style: AppTextStyle.lightDefaultStyle().copyWith(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Your Post Information',
                      style: AppTextStyle.darkDefaultStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: double.infinity, // Set width to match other containers
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.deepPurple, width: 2),
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.lightPurple,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: DropdownButton<String>(
                                  value: selectedValue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: AppTextStyle.darkDefaultStyle(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue!;
                                    });
                                  },
                                  items: <String>['Hearing deficiency', 'Speech disorders', 'Blindness', 'Locomotor impairments', 'Mental illness', 'Elders']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: TextFormField(
                              controller: priceController,
                              obscureText: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numeric input
                              ],
                              decoration: InputDecoration(
                                labelText: 'Price (lei/hour)',

                                labelStyle: AppTextStyle.darkDefaultStyle(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.deepPurple,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.deepPurple,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: AppColors.lightPurple,
                              ),
                              style: AppTextStyle.darkDefaultStyle(),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: TextFormField(
                              maxLines: 3,
                              controller: descriptionController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: AppTextStyle.darkDefaultStyle(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.deepPurple,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.deepPurple,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: AppColors.lightPurple,
                              ),
                              style: AppTextStyle.darkDefaultStyle(),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async{
                              String? errorResponse = await _post();
                              if (errorResponse == null) {
                                final snackBar = SnackBarCustom(text: "Post successful");
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBarCustom(text: errorResponse);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Add Post',
                              style: AppTextStyle.lightDefaultStyle().copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<String?> _post() async{
    CustomHttpClient httpClient = CustomHttpClient();

    final Map<String, String> headers = {
      'Content-Type':'application/json',
    };
    postModel.postType='CARETAKER';
    postModel.email=email;
    switch (selectedValue) {
      case 'Hearing deficiency':
        postModel.category = 'SURD';
        break;
      case 'Speech disorders':
        postModel.category = 'MUT';
        break;
      case 'Blindness':
        postModel.category = 'NEVAZATOR';
        break;
      case 'Locomotor impairments':
        postModel.category = ' PARALIZIE';
        break;
      case 'Mental illness':
        postModel.category = 'MENTAL';
        break;
      case 'Elders':
        postModel.category = 'VARSTNICI';
        break;
      default:
      // Handle the case where selectedValue doesn't match any of the specified cases
        break;
    }
    String body = jsonEncode(postModel.toJson());
    print(body);
    final response = await httpClient.post(path: '${APIConstants.postUrl}/save', headers: headers, body: body);
    if(response.statusCode == 200){
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if(!APIResponseHandler.hasErrors(responseBody)){
        print("Post successful");
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