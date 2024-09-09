import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/pdf_view_controller.dart';

import '../controllers/login_page_controller.dart';

class PdfView extends StatelessWidget {
  final loginController = Get.find<LoginPageController>();
  final controller = Get.find<PdfViewController>();
  final FocusNode _focusNode = FocusNode();

  PdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen for focus changes
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // User clicked away
        controller.onChangePageCancel();
      }
    });

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          _buildPdfContent(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        children: [
          Spacer(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: controller.onPrevious,
                    icon: const Icon(Icons.navigate_before),
                  ),
                  Obx(
                        () => Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              focusNode: _focusNode,
                              onEditingComplete: () {
                                _focusNode.unfocus(); // Dismiss the keyboard
                                controller.onChangePageSubmit(); // Call on submit
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                isDense: true,
                              ),
                              controller: controller.currentPageTextController,
                            ),
                          ),
                        ),
                        Text(
                          "  /  ${loginController.selectedPdfTotalPages}",
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: controller.onNext,
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildPdfContent() {
    return Expanded(
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
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: const Text("Footer"),
    );
  }
}