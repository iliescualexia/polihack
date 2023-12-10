import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/notification_provider.dart';
import 'package:test_project/providers/post_provider.dart';
import 'package:test_project/providers/user_provider.dart';
import '../navigation/route_type.dart';
import '../utils/app_colors.dart';



class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {

  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = context.watch<PostProvider>();
    final UserProvider userProvider = context.read<UserProvider>();
    final NotificationProvider notificationProvider = context.watch<NotificationProvider>();
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      appBar: AppBar(
        backgroundColor: AppColors.deepPurple,
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteType.ViewAccountPage.path());
                  print('Button 1 pressed!');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      'View Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              userProvider.user?.role=='CARETAKER' ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteType.AddPostPage.path());
                  print('Button 2 pressed!');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      'Add Post',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),
              SizedBox(height: 16.0),
              userProvider.user?.role!='CARETAKER' ? ElevatedButton(
                onPressed: () async {
                  await postProvider.fetchPosts("");
                  Navigator.of(context)
                      .pushNamed(RouteType.ViewPostsPage.path());
                  print('Button 3 pressed!');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      'View Posts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),
              SizedBox(width: 16.0),
              userProvider.user?.role=='CARETAKER'? ElevatedButton(
                onPressed: () async{
                  await notificationProvider.fetchNotifications(userProvider.user!.email);
                  Navigator.of(context)
                      .pushNamed(RouteType.ViewNotificationsPage.path());
                  print('Button 4 pressed!');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}