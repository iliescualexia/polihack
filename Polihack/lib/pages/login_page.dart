import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/main.dart';
import 'package:test_project/utils/app_gradient.dart';
import 'package:test_project/utils/custom_sizes.dart';

import '../models/login/login_credential_model.dart';
import '../utils/app_text_style.dart';
import '../widgets/credential_text_field_widget.dart';
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
                          hintText: 'Username',
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
                              await _login();
                              //TODO: on login
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
                              //TODO: on register
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

  Future<void> _login() async {
    setState(() {
      isLoadingLogin = true;
    });
    final response = await supabase.auth.signInWithPassword(email: 'a@a',password: '2');
    print(response);
        // Replace with your actual login logic
    // final AuthResponse res = await supabase.auth.signInWithPassword(
    //   email: 'm@m.com',
    //   password: '1',
    // );
    // final Session? session = res.session;
    // final User? user = res.user;
    //     print('Login response: $res');
    //
    //     if (res.user != null) {
    //       // Login successful, handle navigation or any other logic
    //       print('Login successful');
    //     } else {
    //       // Handle login error
    //       print('Login error:');
    //     }
    //
    //     setState(() {
    //       isLoadingLogin = false;
    //     });
}


}

