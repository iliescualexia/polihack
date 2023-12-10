import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/pages/main_menu_page.dart';
import '../configuration/custom_http_client.dart';
import '../providers/user_provider.dart';
import '../utils/app_gradient.dart';
import '../utils/app_colors.dart';

class AccountInfo {
  final String fullName;
  final String email;
  final String accountType;

  AccountInfo({
    required this.fullName,
    required this.email,
    required this.accountType,
  });
}

class ViewAccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
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
            );
            print('Arrow button pressed!');
          },
        ),
        title: Text('My Account'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppGradient.cardGradient(),
            ),
          ),
          Center(
            child: UserCard(
              fullName: userProvider.user!.firstName +" "+ userProvider.user!.lastName ,
              email: userProvider.user!.email,
              accountType:userProvider.user!.role != "CARETAKER" ? "Person with disabilities":"Caretaker",
            ),
          ),
        ],
      ),
    );
  }

}

class UserCard extends StatelessWidget {
  final String fullName;
  final String email;
  final String accountType;

  UserCard({
    required this.fullName,
    required this.email,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: AppGradient.backgroundGradient2(),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://picsum.photos/id/433/200/300'),
            ),
            SizedBox(height: 16),
            Text(
              fullName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Account Type: $accountType',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

}
