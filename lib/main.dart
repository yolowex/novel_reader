import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/constants.dart';

void main() {
  runApp(NovelReader());
}

class NovelReader extends StatefulWidget{



  @override
  State<NovelReader> createState() => _NovelReaderState();
}

class _NovelReaderState extends State<NovelReader> {
  @override
  void initState() {
    // TODO: implement initState
    asyncInit();
    super.initState();
  }
  Future<void> asyncInit() async{

  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
