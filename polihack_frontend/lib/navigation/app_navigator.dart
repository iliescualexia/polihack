import 'package:flutter/material.dart';
import 'package:test_project/navigation/route_type.dart';
import 'package:test_project/pages/add_post_page.dart';
import 'package:test_project/pages/add_record_page.dart';
import 'package:test_project/pages/notification_page.dart';
import 'package:test_project/pages/register_page_caretakers.dart';
import 'package:test_project/pages/view_account_page.dart';
import 'package:test_project/pages/view_posts_page.dart';

import '../pages/login_page.dart';
import '../pages/main_menu_page.dart';
import '../pages/register_page_disabilities.dart';
import '../pages/type_of_account.dart';
class AppNavigator {
  static RouteObserver navigationObserver = RouteObserver();
  static Route? generateRoute(RouteSettings routeSettings) {
    for (RouteType route in RouteType.values) {
      if (route.path() == routeSettings.name) {
        switch (route) {
          case RouteType.LoginPage:
            return MaterialPageRoute(builder: (BuildContext context) {
              return const LoginPage();
            });
          case RouteType.RegisterPageDisabilities:
            return MaterialPageRoute(builder: (BuildContext context ){
              return const RegisterPageDisabilities();
            });
          case RouteType.TypeOfAccount:
            return MaterialPageRoute(builder: (BuildContext context ){
              return const TypeOfAccountPage();
            });
          case RouteType.RegisterPageCaretakers:
            return MaterialPageRoute(builder: (BuildContext context ){
              return const RegisterCaregiverPageDisabilities();
            });
          case RouteType.AddRecordPage:
            return MaterialPageRoute(builder: (BuildContext context ){
              return const AddRecordPage();
            });
          case RouteType.MainMenuPage:
            return MaterialPageRoute(builder: (BuildContext context ){
              return const MainMenuPage();
            });
          case RouteType.ViewAccountPage:
            return MaterialPageRoute(builder: (BuildContext context ){
              return ViewAccountPage();
            });
          case RouteType.AddPostPage:
            return MaterialPageRoute(builder: (BuildContext context ){
              return AddPostPage();
            });
          case RouteType.ViewPostsPage:
          return MaterialPageRoute(builder: (BuildContext context ){
            return const ViewPostsPage();
          });
          case RouteType.ViewNotificationsPage:
            return MaterialPageRoute(builder: (BuildContext context ){
              return const ViewNotificationsPage();
            });
        }
      }
    }
    return null;
  }

  static MaterialPageRoute unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const LoginPage();
    });
  }
}
