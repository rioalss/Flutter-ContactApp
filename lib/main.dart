import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/routes/app_page.dart';
import 'package:test/routes/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contact App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: false,
      ),
      getPages: AppPages.pages,
      initialRoute: RouteName.loginPage,
    );
  }
}
