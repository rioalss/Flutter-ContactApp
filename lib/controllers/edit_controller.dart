import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/models/user_contact_model.dart';
import 'package:test/routes/route_name.dart';
import 'package:test/services/fetch_user_service.dart';

class EditController extends GetxController {
  final FetchUserService fetchUserService = FetchUserService();
  final users = <UserContactModel>[].obs;

  Future<void> updateUser(
    int id,
    String firstName,
    String lastName,
    String email,
    String avatar,
    String job,
    String phone,
    String web,
  ) async {
    try {
      final newUser = await fetchUserService.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        avatar: avatar,
        job: job,
        phone: phone,
        web: web,
      );
      users.add(newUser);

      Get.snackbar(
        'Success',
        'User updated',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Future.delayed(const Duration(seconds: 2))
          .then((_) => Get.offAllNamed(RouteName.homePage));
    } catch (e) {
      dev.log('Error creating user : $e');
    }
  }
}
