import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/pdf_view_controller.dart';

import '../controllers/login_page_controller.dart';

class PdfView extends StatelessWidget {
  final loginController = Get.find<LoginPageController>();
  final controller = Get.find<PdfViewController>();
  final FocusNode _textFormFieldFocusNode = FocusNode();

  PdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen for focus changes
    _textFormFieldFocusNode.addListener(() {
      if (!_textFormFieldFocusNode.hasFocus) {
        // User clicked away
        controller.onChangePageCancel();
      }
    });

    return Focus(
      onKeyEvent: (FocusNode node, KeyEvent event) {
        // Prevent focus change on arrow key

        if (event is KeyDownEvent) {
          if (_textFormFieldFocusNode.hasFocus) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
                event.logicalKey == LogicalKeyboardKey.arrowRight) {
              return KeyEventResult.ignored;
            }
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
              event.logicalKey == LogicalKeyboardKey.arrowRight ||
              event.logicalKey == LogicalKeyboardKey.arrowUp ||
              event.logicalKey == LogicalKeyboardKey.arrowDown) {
            // Consume the event to prevent focus change

            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              controller.onGoNextPage();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              controller.onGoPreviousPage();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              controller.animateScrollUp();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              controller.animateScrollDown();
            }

            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.shiftRight ||
              event.logicalKey == LogicalKeyboardKey.numpadAdd) {
            controller.increaseContentTextSize();
          }
          if (event.logicalKey == LogicalKeyboardKey.controlRight ||
              event.logicalKey == LogicalKeyboardKey.numpadSubtract) {
            controller.decreaseContentTextSize();
          }
        }

        return KeyEventResult.ignored;
      },
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(context),
            _buildPdfContent(),
            _buildFooter(),
          ],
        ),
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
                    onPressed: controller.onGoPreviousPage,
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
                              focusNode: _textFormFieldFocusNode,
                              onEditingComplete: () {
                                _textFormFieldFocusNode
                                    .unfocus(); // Dismiss the keyboard
                                controller
                                    .onChangePageSubmit(); // Call on submit
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                    onPressed: controller.onGoNextPage,
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
                  () {
                // Split the content string into words
                List<String> words = controller.contentString.value.split(' ');

                // Create a list of TextSpans for each word
                List<TextSpan> textSpans = words.map((word) {
                  // Check if the word is "Harry"
                  bool isHarry = word.toLowerCase() == 'harry';
                  var paint = Paint();
                  paint.color = Colors.yellow;

                  return TextSpan(
                    text: word + ' ', // Add a space after each word
                    style: controller.contentTextStyle.copyWith(
                      fontSize: controller.contentTextFontSize.value,
                      background: isHarry?  paint: null // Highlight background for "Harry"
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Print the clicked word
                        print(word);
                      },
                  );
                }).toList();

                return Center(
                  child: RichText(
                    text: TextSpan(
                      children: textSpans,
                      style: controller.contentTextStyle.copyWith(
                        fontSize: controller.contentTextFontSize.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfContent02() {
    return Expanded(
      child: ListView(
        controller: controller.contentScrollController,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade500,
            child: Obx(
                  () {
                // Split the content string into words
                List<String> words = controller.contentString.value.split(' ');

                // Create a list of TextSpans for each word
                List<TextSpan> textSpans = words.map((word) {
                  // Check if the word is "Harry"
                  bool isHarry = word.toLowerCase() == 'harry';

                  return TextSpan(
                    text: word + ' ', // Add a space after each word
                    style: controller.contentTextStyle.copyWith(
                      fontSize: controller.contentTextFontSize.value,
                      color: isHarry ? Colors.yellow : null, // Highlight "Harry" in yellow
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Print the clicked word
                        print(word);
                      },
                  );
                }).toList();

                return Center(
                  child: RichText(
                    text: TextSpan(
                      children: textSpans,
                      style: controller.contentTextStyle.copyWith(
                        fontSize: controller.contentTextFontSize.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfContent01() {
    return Expanded(
      child: ListView(
        controller: controller.contentScrollController,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade500,
            child: Obx(
                  () {
                // Split the content string into words
                List<String> words = controller.contentString.value.split(' ');

                // Create a list of TextSpans for each word
                List<TextSpan> textSpans = words.map((word) {
                  return TextSpan(
                    text: word + ' ', // Add a space after each word
                    style: controller.contentTextStyle.copyWith(
                      fontSize: controller.contentTextFontSize.value,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Print the clicked word
                        print(word);
                      },
                  );
                }).toList();

                return Center(
                  child: RichText(
                    text: TextSpan(
                      children: textSpans,
                      style: controller.contentTextStyle.copyWith(
                        fontSize: controller.contentTextFontSize.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfContent0() {
    return Expanded(
      child: ListView(
        controller: controller.contentScrollController,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade500,
            child: Obx(
              () => Center(
                child: Text(
                  controller.contentString.value,
                  style: controller.contentTextStyle.copyWith(
                    fontSize: controller.contentTextFontSize.value,
                  ),
                ),
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
