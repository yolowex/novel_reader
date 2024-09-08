import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:novel_reader/common/utils.dart';
import 'package:novel_reader/controllers/login_page_controller.dart';
import 'package:novel_reader/services/pdf_service.dart';

class PdfViewController extends GetxController {
  RxInt selectedPdfPage = 1.obs;
  RxString contentString = "content".obs;
  ScrollController contentScrollController = ScrollController();

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

  void onNext() {
    var loginController = Get.find<LoginPageController>();
    var tmp = selectedPdfPage.value;
    tmp += 1;
    if (tmp > loginController.selectedPdfTotalPages.value) {
      tmp = loginController.selectedPdfTotalPages.value;
    }
    selectedPdfPage.value = tmp;
    updateContent();
    contentScrollController.jumpTo(0);
  }

  void onPrevious() {
    var tmp = selectedPdfPage.value;
    tmp -= 1;
    if (tmp < 1) tmp = 1;
    selectedPdfPage.value = tmp;
    updateContent();
    contentScrollController.jumpTo(0);
  }
}
