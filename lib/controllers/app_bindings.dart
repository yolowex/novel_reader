import 'package:get/get.dart';
import 'package:novel_reader/controllers/login_page_controller.dart';


class AppBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(LoginPageController(),permanent: true);
  }
}