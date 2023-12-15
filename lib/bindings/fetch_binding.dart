import 'package:get/get.dart';
import 'package:test/controllers/fetch_controller.dart';

class FetchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FetchController());
  }
}
