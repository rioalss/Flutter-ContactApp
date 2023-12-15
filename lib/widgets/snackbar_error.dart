import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackbarError(Object e) {
  Get.snackbar(
    "Error",
    e.toString(),
    animationDuration: const Duration(seconds: 2),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red.withOpacity(.75),
    colorText: Colors.white,
    icon: const Icon(Icons.error, color: Colors.white),
    shouldIconPulse: true,
    barBlur: 20,
  );
}
