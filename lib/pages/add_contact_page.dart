import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test/controllers/create_user_controller.dart';
import 'package:test/routes/route_name.dart';
import 'package:test/widgets/text_field_contact_widget.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    final addUserControler = Get.find<CreateUserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Contact'),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(RouteName.homePage);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          SizedBox(
            width: 70,
            child: IconButton(
              onPressed: () {
                addUserControler.createUser();
                addUserControler.firstNameController.clear();
                addUserControler.lastNameController.clear();
                addUserControler.emailController.clear();
                addUserControler.jobController.clear();
                addUserControler.phoneController.clear();
                addUserControler.webController.clear();
              },
              icon: const Text(
                'SAVE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: addUserControler.imageXFile == null
                    ? null
                    : FileImage(File(addUserControler.imageXFile!.path)),
                backgroundColor: Colors.blue.shade900,
                radius: 60,
                child: IconButton(
                    onPressed: () async {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.storage,
                        Permission.camera,
                      ].request();
                      if (statuses[Permission.storage]!.isGranted &&
                          statuses[Permission.camera]!.isGranted) {
                        await addUserControler.pickImageFromGalery();
                        setState(() {
                          addUserControler.imageXFile;
                          visible = false;
                        });
                      } else {
                        log('no permission provided');
                      }
                    },
                    icon: (visible
                        ? const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.camera,
                            color: Colors.transparent,
                          ))),
              ),
              textFieldContactWidget(Icons.person_rounded, 'First Name',
                  addUserControler.firstNameController),
              textFieldContactWidget(Icons.person_rounded, 'Last Name',
                  addUserControler.lastNameController),
              textFieldContactWidget(
                  Icons.work, 'Job', addUserControler.jobController),
              textFieldContactWidget(
                  Icons.call, 'Phone', addUserControler.phoneController),
              textFieldContactWidget(
                  Icons.email, 'Email', addUserControler.emailController),
              textFieldContactWidget(
                  Icons.web, 'Web', addUserControler.webController),
            ],
          ),
        ),
      ),
    );
  }

}
