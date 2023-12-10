import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/main.dart';
import 'package:test_project/models/login/login_mapping_extension.dart';
import 'package:test_project/providers/caregiver_provider.dart';
import 'package:test_project/utils/app_gradient.dart';
import 'package:test_project/utils/custom_sizes.dart';

import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/login/login_credential_model.dart';
import '../navigation/route_type.dart';
import '../providers/disability_provider.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_text_style.dart';
import '../widgets/credential_text_field_widget.dart';
import '../widgets/snack_bar_custom.dart';
import '../widgets/text_button_one.dart';
import '../widgets/text_button_two.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCredentialsModel loginCredentialsModel = LoginCredentialsModel();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool isLoadingLogin = false;
  String email = "";
  @override
  void initState() {
    emailController = TextEditingController(text: loginCredentialsModel.email);
    passwordController = TextEditingController(text: loginCredentialsModel.password);

    emailController.addListener(() {
      loginCredentialsModel.email = emailController.text;
    });

    passwordController.addListener(() {
      loginCredentialsModel.password = passwordController.text;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppGradient.settingsGradient()),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: CustomSizes.defaultHorizontalOffset() * 4),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Spacer(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset()),
                        child: Text(
                          'Welcome!',
                          style: AppTextStyle.titleStyle(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: CustomSizes.defaultVerticalOffset(), bottom: CustomSizes.defaultVerticalOffset()*10),
                        child: Text(
                          'Log in to continue',
                          style: AppTextStyle.lightDefaultStyle(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2),
                        child: CredentialsTextFieldWidget(
                          controller: emailController,
                          obscureText: false,
                          hintText: 'Email',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2),
                        child: CredentialsTextFieldWidget(
                          controller: passwordController,
                          obscureText: true,
                          hintText: 'Password',
                        ),
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      if(isLoadingLogin)
                        Center(child: CircularProgressIndicator()),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: CustomSizes.defaultVerticalOffset() * 2),
                          child: TextButtonOne(
                            text: 'Login',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String? errorResponse = await _login();
                                if (errorResponse == null) {
                                  Navigator.of(context)
                                      .pushNamed(RouteType.MainMenuPage.path());
                                } else {
                                  final snackBar = SnackBarCustom(
                                      text: errorResponse);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: CustomSizes.defaultVerticalOffset() * 10),
                          child: TextButtonTwo(
                            text: 'Register',
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteType.TypeOfAccount.path());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  // Inside your _LoginPageState class

  Future<String?> _login() async {
    setState(() {
      isLoadingLogin = true;
    });
    CustomHttpClient httpClient = CustomHttpClient();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String body = jsonEncode(loginCredentialsModel.toJson());

    final response = await httpClient.post(
        path: APIConstants.loginUrl, headers: headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (!APIResponseHandler.hasErrors(responseBody)) {

        final Map<String, dynamic> userData =
        responseBody['object'] as Map<String, dynamic>;
        setState(() {
          email = userData['email'];
        });
        final UserProvider userProvider = context.read<UserProvider>();
        await context.read<UserProvider>().fetchUserData(email);

        final PostProvider postProvider = context.read<PostProvider>();
        await context.read<PostProvider>().fetchPosts('');
        if(userProvider.user?.role == "CARETAKER"){
          final CaregiverProvider caregiverProvider = context.read<CaregiverProvider>();
          await context.read<CaregiverProvider>().fetchCaregiverData(email);
        }else{
          final DisabilityProvider disabilityProvider = context.read<DisabilityProvider>();
          await context.read<DisabilityProvider>().fetchDisabilityData(email);
        }



        print(userProvider.user?.city);
        setState(() {
          isLoadingLogin = false;
        });
      } else {
        setState(() {
          isLoadingLogin = false;
        });
        return APIResponseHandler.getData(responseBody);
      }
    } else {
      setState(() {
        isLoadingLogin = false;
      });
      return "Internal server error. Please try again.";
    }
  }


}

