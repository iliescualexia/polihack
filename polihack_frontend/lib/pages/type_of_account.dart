import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/main.dart';
import 'package:test_project/models/login/login_mapping_extension.dart';
import 'package:test_project/utils/app_gradient.dart';
import 'package:test_project/utils/custom_sizes.dart';

import '../configuration/api_constants.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/custom_http_client.dart';
import '../models/login/login_credential_model.dart';
import '../navigation/route_type.dart';
import '../utils/app_text_style.dart';
import '../widgets/credential_text_field_widget.dart';
import '../widgets/snack_bar_custom.dart';
import '../widgets/text_button_one.dart';
import '../widgets/text_button_two.dart';

class TypeOfAccountPage extends StatefulWidget {
  const TypeOfAccountPage({super.key});

  @override
  State<TypeOfAccountPage> createState() => _TypeOfAccountPageState();
}

class _TypeOfAccountPageState extends State<TypeOfAccountPage> {
  @override
  void initState() {

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
                    Center(
                      child: Text(
                        "Select The Type Of Account",
                        style: AppTextStyle.lightDefaultStyle(),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: CustomSizes.defaultVerticalOffset() * 10),
                        child: TextButtonOne(
                          text: 'Person with disabilities',
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(RouteType.RegisterPageDisabilities.path());
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: CustomSizes.defaultVerticalOffset() * 10),
                        child: TextButtonOne(
                          text: 'Caretaker',
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(RouteType.RegisterPageCaretakers.path());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

