import 'package:get/get.dart';
import 'package:test/controllers/delete_controller.dart';

class DeleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DeleteController());
  }
}
