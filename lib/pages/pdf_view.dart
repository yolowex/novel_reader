import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/pdf_view_controller.dart';

import '../controllers/login_page_controller.dart';

class PdfView extends StatelessWidget {
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
                      IconButton(
                        onPressed: controller.onPrevious,
                        icon: const Icon(Icons.navigate_before),
                      ),
                      Obx(
                        () => Text(
                            "${controller.selectedPdfPage}  /  ${loginController.selectedPdfTotalPages}",),
                      ),
                      IconButton(
                        onPressed: controller.onNext,
                        icon: const Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: controller.contentScrollController,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade500,
                  child: Obx(
                    () => Center(
                      child: Text(controller.contentString.value),
                    ),
                  ),
                ),
              ],
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
