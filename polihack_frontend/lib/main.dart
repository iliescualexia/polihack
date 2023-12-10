import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/pages/login_page.dart';
import 'package:test_project/providers/caregiver_provider.dart';
import 'package:test_project/providers/disability_provider.dart';
import 'package:test_project/providers/notification_provider.dart';
import 'package:test_project/providers/post_provider.dart';
import 'package:test_project/providers/user_provider.dart';

import 'navigation/app_navigator.dart';

void main() {
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (BuildContext context) => UserProvider(),
      ),
      ChangeNotifierProvider<CaregiverProvider>(
        create: (BuildContext context) => CaregiverProvider(),
      ),
      ChangeNotifierProvider<DisabilityProvider>(
        create: (BuildContext context) => DisabilityProvider(),
      ),
      ChangeNotifierProvider<PostProvider>(
        create: (BuildContext context) => PostProvider(),
      ),
      ChangeNotifierProvider<NotificationProvider>(
        create: (BuildContext context) => NotificationProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      onGenerateRoute: AppNavigator.generateRoute,
      onUnknownRoute: AppNavigator.unknownRoute,
      navigatorObservers: [AppNavigator.navigationObserver],
    );
  }
}
