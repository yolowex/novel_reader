import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/login_page_controller.dart';
import 'package:novel_reader/services/pdf_service.dart';

class PdfViewController extends GetxController {
  RxInt selectedPdfPage = 1.obs;
  RxString contentString = "content".obs;

  void updateContent() async {
    var loginController = Get.find<LoginPageController>();

    contentString.value = await PdfService().extractTextFromPdf(
      loginController.selectedPdfPath.value,
      selectedPdfPage.value,
    );
  }
}
