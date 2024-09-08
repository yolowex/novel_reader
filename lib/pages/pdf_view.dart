import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/pdf_view_controller.dart';

import '../controllers/login_page_controller.dart';



class PdfView extends StatelessWidget{
  var loginController = Get.find<LoginPageController>();
  var controller = Get.find<PdfViewController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: Row(
              children: [
                Spacer(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.navigate_before),),
                      Text("${controller.selectedPdfPage}  /  ${loginController.selectedPdfTotalPages}"),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.navigate_next),),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(controller.contentString.value)),
                ],
              ),
            
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: Text("Footer"),

          ),
        ],
      ),
    );
  }
}

