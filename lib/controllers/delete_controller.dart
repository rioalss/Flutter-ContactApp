import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/routes/route_name.dart';
import 'package:test/services/fetch_user_service.dart';

class DeleteController extends GetxController {
  final FetchUserService fetchUserService = FetchUserService();
  void deleteUser(int id) async {
    try {
      final isDelete = await fetchUserService.deleteUser(id: id);
      if (isDelete) {
        Get.offAllNamed(RouteName.homePage);
        Future.delayed(const Duration(seconds: 1)).then((_) => Get.snackbar(
              'Success',
              'User deleted',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            ));
      } else {
        log('Error delete data');
      }
    } catch (e) {
      log('Error delete data $e');
    }
  }
}
