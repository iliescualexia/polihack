import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/utils/app_colors.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  void _openGallery() async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  void _sendPicture() {
    // Implement the logic to send the picture
    // This is a placeholder function
    if (_pickedImage != null) {
      print('Sending picture: ${_pickedImage!.path}');
      _showSnackBar('Image sent');
    } else {
      print('No picture selected');
      _showSnackBar('No picture selected');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      appBar: AppBar(
        backgroundColor: AppColors.lightPurple,
        title: Row(
          children: [
            SizedBox(width: 8),
            Text('Upload Criminal Record'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openGallery,
              style: ElevatedButton.styleFrom(
                primary: AppColors.lightPurple,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Open Gallery',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 16),
            _pickedImage != null
                ? Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(_pickedImage!.path)),
                  fit: BoxFit.cover,
                ),
              ),
            )
                : Text(
              'No picture selected',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _sendPicture();
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.lightPurple,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Send Image',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}