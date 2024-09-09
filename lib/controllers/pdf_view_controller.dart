import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/common/utils.dart';
import 'package:novel_reader/controllers/login_page_controller.dart';
import 'package:novel_reader/services/pdf_service.dart';

class PdfViewController extends GetxController {
  RxInt selectedPdfPage = 1.obs;
  RxString contentString = "content".obs;
  ScrollController contentScrollController = ScrollController();
  late TextEditingController currentPageTextController = TextEditingController(
    text: "${selectedPdfPage.value}",
  );
  TextStyle contentTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
  );
  RxDouble contentTextFontSize = 20.0.obs;

  void animateScrollDown() {
    // Animate down by 100 pixels
    contentScrollController.animateTo(
      contentScrollController.position.pixels + 65,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void animateScrollUp() {
    // Animate up by 100 pixels
    contentScrollController.animateTo(
      contentScrollController.position.pixels - 65,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateContent() async {
    var loginController = Get.find<LoginPageController>();

    contentString.value = breakLongLines(
      addExtraNewline(
        await PdfService().extractTextFromPdf(
          loginController.selectedPdfPath.value,
          selectedPdfPage.value,
        ),
      ),
    );
  }

  void onChangePageSubmit() {
    var loginController = Get.find<LoginPageController>();

    var newPage = currentPageTextController.text;
    try {
      var num = int.parse(newPage);
      if (1 <= num && num <= loginController.selectedPdfTotalPages.value) {
        onSelectedPageUpdate(num);
      }
    } on Exception catch (e) {
      print("Bad input {$newPage} -> \n$e");
    }
  }

  void onChangePageCancel() {
    currentPageTextController.text = "${selectedPdfPage.value}";
  }

  void onSelectedPageUpdate(int newPage) {
    selectedPdfPage.value = newPage;
    updateContent();
    currentPageTextController.text = "${selectedPdfPage.value}";
    contentScrollController.jumpTo(0);
  }

  void onGoNextPage() {
    var loginController = Get.find<LoginPageController>();
    var tmp = selectedPdfPage.value;
    tmp += 1;
    if (tmp > loginController.selectedPdfTotalPages.value) {
      tmp = loginController.selectedPdfTotalPages.value;
    }
    onSelectedPageUpdate(tmp);
  }

  void onGoPreviousPage() {
    var tmp = selectedPdfPage.value;
    tmp -= 1;
    if (tmp < 1) tmp = 1;
    onSelectedPageUpdate(tmp);
  }

  void increaseContentTextSize(){
    var tmp = contentTextFontSize.value;
    tmp += 1;
    if (tmp > 40) tmp = 40;
    contentTextFontSize.value = tmp;
  }

  void decreaseContentTextSize(){
    var tmp = contentTextFontSize.value;
    tmp -= 1;
    if (tmp < 15) tmp = 15;
    contentTextFontSize.value = tmp;
  }
}
