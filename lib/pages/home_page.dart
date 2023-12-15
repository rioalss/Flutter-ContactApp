import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/fetch_controller.dart';
import 'package:test/models/user_contact_model.dart';
import 'package:test/routes/route_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  final fetchDataController = Get.find<FetchController>();
  List<UserContactModel> results = [];
  @override
  initState() {
    results = fetchDataController.users;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      if (enteredKeyword.isEmpty) {
        results = fetchDataController.users;
      } else {
        results = fetchDataController.users
            .where((user) => user.firstName
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('Contact'),
        actions: [
          IconButton(
            icon: Icon(isSearchClicked ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
                if (!isSearchClicked) {
                  _searchController.clear();
                  results = fetchDataController.users;
                }
              });
            },
          )
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: results[index].avatar.contains('https') == true
                    ? NetworkImage(results[index].avatar)
                    : FileImage(File(results[index].avatar)) as ImageProvider,
              ),
              title: Text(
                  '${results[index].firstName} ${results[index].lastName}'),
              subtitle: Text(results[index].email),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    fetchDataController.onClickFav();
                    if (fetchDataController.isFav.value == true) {
                      results[index].isFavorite = true;
                    } else {
                      results[index].isFavorite = false;
                    }
                  });
                },
                icon: results[index].isFavorite == true
                    ? Icon(
                        Icons.star,
                        color: Colors.blue.shade900,
                      )
                    : const Icon(Icons.star_border_outlined),
              ),
              onTap: () {
                Get.toNamed(RouteName.detailPage, arguments: results[index]);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.offAllNamed(RouteName.addContactPage);
        },
      ),
    );
  }
}
