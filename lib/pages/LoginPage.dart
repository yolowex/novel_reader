import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  var controller = Get.find<LoginPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                const XTypeGroup typeGroup = XTypeGroup(
                  label: 'pdf files',
                  extensions: <String>['pdf'],
                );
                final XFile? file = await openFile(
                  initialDirectory: "/home/pickle/Downloads/books",
                  acceptedTypeGroups: <XTypeGroup>[typeGroup],
                );
                if (file == null) {
                  print("No file");
                } else {
                  print(file.path);
                }
              },
              child: const Text(
                "Select a pdf",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
