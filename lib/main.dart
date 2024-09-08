import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/app_bindings.dart';
import 'package:novel_reader/pages/LoginPage.dart';

void main() {
  AppBindings().dependencies();
  runApp(NovelReader());
}

class NovelReader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
