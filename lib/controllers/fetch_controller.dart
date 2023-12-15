import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/models/user_contact_model.dart';
import 'package:test/services/fetch_user_service.dart';

class FetchController extends GetxController {
  final FetchUserService fetchUserService = FetchUserService();
  final users = <UserContactModel>[].obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  late UserContactModel userModel;
  final picker = ImagePicker();
  late Rx<File?> imgFile;
  XFile? imageXFile;
  File? imageFile;
  RxBool isFav = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  onClickFav() => isFav.value = !isFav.value;

  void fetchUserData() async {
    try {
      final userList = await fetchUserService.fetchUser();
      users.assignAll(userList);
    } catch (e) {
      dev.log('Error fetching user data $e');
    }
  }
}
