import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/models/user_contact_model.dart';
import 'package:test/routes/route_name.dart';
import 'package:test/services/fetch_user_service.dart';

class CreateUserController extends GetxController {
  final FetchUserService fetchUserService = FetchUserService();
  final users = <UserContactModel>[].obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final webController = TextEditingController();
  final jobController = TextEditingController();
  final picker = ImagePicker();
  late Rx<File?> imgFile;
  XFile? imageXFile;
  File? imageFile;


  pickImageFromGalery() async {
    imageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar(
          'Profile Image', 'You have succesfully picked your profile image');
    }
    imgFile = Rx<File?>(File(imageXFile!.path));
  }

  Future<void> createUser() async {
    try {
      final newUser = await fetchUserService.createUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        avatar: imageXFile!.path.toString(),
        job: jobController.text,
        phone: phoneController.text,
        web: webController.text,

      );
      users.add(newUser);
      Get.offAllNamed(RouteName.addContactPage);
      Future.delayed(const Duration(seconds: 1)).then((_) => Get.snackbar(
            'Success',
            'New user created',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          ));
    } catch (e) {
      dev.log('Error creating user : $e');
    }
  }
}
