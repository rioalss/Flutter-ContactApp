import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/edit_controller.dart';
import 'package:test/routes/route_name.dart';
import 'package:test/widgets/text_field_contact_widget.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final dataUser = Get.arguments;
  bool visible = false;
  // void fetchUserData() async {
  //   final FetchUserService fetchUserService = FetchUserService();
  //   final users = <UserContactModel>[];
  //   try {
  //     final userList = await fetchUserService.fetchUserById(dataUser.id);
  //     users.assignAll(userList);
  //   } catch (e) {
  //     log('Error fetching student data $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController =
        TextEditingController(text: dataUser.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: dataUser.lastName);
    TextEditingController emailController =
        TextEditingController(text: dataUser.email);
    TextEditingController jobController = TextEditingController(text: null);
    TextEditingController phoneController = TextEditingController(text: null);
    TextEditingController webController = TextEditingController(text: null);
    var editController = Get.find<EditController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(RouteName.homePage);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          SizedBox(
            width: 90,
            child: IconButton(
              onPressed: () async {
                await editController.updateUser(
                  int.parse(dataUser.id.toString()),
                  firstNameController.text,
                  lastNameController.text,
                  emailController.text,
                  '',
                  jobController.text,
                  phoneController.text,
                  webController.text,
                );
              },
              icon: const Text(
                'UPDATE',
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
                backgroundImage: dataUser.avatar == null
                    ? null
                    : NetworkImage(dataUser.avatar),
                backgroundColor: Colors.blue.shade900,
                radius: 60,
                child: IconButton(
                    onPressed: () async {
                      // Map<Permission, PermissionStatus> statuses = await [
                      //   Permission.storage,
                      //   Permission.camera,
                      // ].request();
                      // if (statuses[Permission.storage]!.isGranted &&
                      //     statuses[Permission.camera]!.isGranted) {
                      //   await addUserControler.pickImageFromGalery();
                      //   setState(() {
                      //     addUserControler.imageXFile;
                      //     visible = false;
                      //   });
                      // } else {
                      //   log('no permission provided');
                      // }
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
              textFieldContactWidget(
                Icons.person_rounded,
                'First Name',
                firstNameController,
              ),
              textFieldContactWidget(
                  Icons.person_rounded, 'Last Name', lastNameController),
              textFieldContactWidget(Icons.work, 'Job', jobController),
              textFieldContactWidget(Icons.call, 'Phone', phoneController),
              textFieldContactWidget(Icons.email, 'Email', emailController),
              textFieldContactWidget(Icons.web, 'Web', webController),
            ],
          ),
        ),
      ),
    );
  }

  
}
