import 'package:get/get.dart';
import 'package:test/controllers/create_user_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateUserController());
  }
}
