import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/notification/notification_model.dart';
import 'package:test_project/providers/notification_provider.dart';
import 'package:test_project/utils/app_gradient.dart';

import '../utils/app_colors.dart';
import 'main_menu_page.dart';


class ViewNotificationsPage extends StatefulWidget {
  const ViewNotificationsPage({Key? key}) : super(key: key);

  @override
  State<ViewNotificationsPage> createState() => _ViewNotificationsPageState();
}

class _ViewNotificationsPageState extends State<ViewNotificationsPage> {
   List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    final NotificationProvider notificationProvider = context.watch<NotificationProvider>();
    notifications = notificationProvider.notifications;
    return MaterialApp(
      home: Scaffold(
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
          title: Text('Notifications'),
        ),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return PostCard(notificationModel: notifications[index]);
          },
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final NotificationModel notificationModel;

  PostCard({required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    final NotificationProvider notificationProvider = context.watch<NotificationProvider>();
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: AppGradient.backgroundGradient()
        ),
        child: ListTile(
          title: Text(
            'New notification',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            '${notificationModel.senderEmail} wants to contact you.',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}