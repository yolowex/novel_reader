import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:novel_reader/controllers/pdf_view_controller.dart';
import 'package:novel_reader/services/pdf_service.dart';

import '../pages/pdf_view.dart';

class LoginPageController extends GetxController {
  RxString selectedPdfPath = "null".obs;
  RxInt selectedPdfTotalPages = (-1).obs;

  void onSelectPdf() async {
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
      print("Opened " +file.path);
      selectedPdfPath.value = file.path;
      selectedPdfTotalPages.value = await PdfService().getTotalPages(file.path);
      print(selectedPdfTotalPages.value);
      var viewController = Get.find<PdfViewController>();
      viewController.updateContent();
      Get.off(() => PdfView());
    }
  }
}
