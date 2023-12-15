import 'package:get/get.dart';
import 'package:test/controllers/edit_controller.dart';

class EditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditController());
  }
}
