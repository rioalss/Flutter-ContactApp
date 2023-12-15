import 'package:flutter/material.dart';

TextField textFieldContactWidget(
      IconData icon, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLength: (label == 'Phone' ? 16 : null),
      keyboardType: switch (label) {
        'Email' => TextInputType.emailAddress,
        'Phone' => TextInputType.phone,
        'Web' => TextInputType.url,
        String() => TextInputType.text,
      },
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(
          icon,
          size: 28,
        ),
      ),
    );
  }

  