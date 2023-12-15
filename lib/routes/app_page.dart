import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:test/bindings/create_binding.dart';
import 'package:test/bindings/delete_binding.dart';
import 'package:test/bindings/edit_binding.dart';
import 'package:test/bindings/fetch_binding.dart';
import 'package:test/bindings/login_binding.dart';
import 'package:test/pages/add_contact_page.dart';
import 'package:test/pages/detail_page.dart';
import 'package:test/pages/edit_page.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/pages/login_page.dart';
import 'route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.loginPage,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.homePage,
      page: () => const HomePage(),
      binding: FetchBinding(),
    ),
    GetPage(
      name: RouteName.detailPage,
      page: () =>  DetailPage(),
      binding: DeleteBinding(),
    ),
    GetPage(
      name: RouteName.addContactPage,
      page: () => const AddContactPage(),
      binding: CreateBinding(),
    ),
    GetPage(
      name: RouteName.editPage,
      page: () => const EditPage(),
      binding: EditBinding(),
    ),
  ];
}
