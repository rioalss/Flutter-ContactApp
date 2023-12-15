import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test/controllers/delete_controller.dart';
import 'package:test/routes/route_name.dart';

import 'package:url_launcher/url_launcher.dart' as launcher;

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final dataUser = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var deleteControler = Get.find<DeleteController>();
    List iconDetail = [
      Icons.call,
      Icons.email,
      Icons.share,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: dataUser.isFavorite
                ? const Icon(
                    Icons.star,
                    color: Colors.white,
                  )
                : const Icon(Icons.star_border_outlined),
          ),
          IconButton(
            onPressed: () {
              Get.offAllNamed(RouteName.editPage, arguments: dataUser);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
              onPressed: () {
                deleteControler.deleteUser(int.parse(dataUser.id.toString()));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(dataUser.avatar),
                  maxRadius: 100,
                  minRadius: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${dataUser.firstName} ${dataUser.lastName}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          detailCard(
            iconDetail[0],
            dataUser.firstName,
            'Phone',
          ),
          detailCard(
            iconDetail[1],
            dataUser.email,
            'Email',
          ),
          detailCard(
            iconDetail[2],
            'Share Contact',
            'Share',
          ),
        ],
      ),
    );
  }

  Card detailCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        onTap: (subtitle == 'Share')
            ? () {
                String number = '12+11233141';
                String msg =
                    "$number Hello this is ${dataUser.firstName} ${dataUser.lastName} number phone.";
                Share.share(msg);
              }
            : (subtitle == 'Email')
                ? () async {
                    Uri uri = Uri(
                      scheme: 'mailto',
                      path: dataUser.email.toString(),
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Example Subject & From Contact App!',
                      }),
                    );
                    if (!await launcher.launchUrl(uri)) {
                      debugPrint(
                          "Could not launch the uri"); // because the emulator doesn't has the email app
                    }
                  }
                : () {},
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Icon(
            icon,
            color: Colors.blue.shade900,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: (icon == Icons.call
            ? IconButton(
                onPressed: () {},
                icon: IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () => launcher.launchUrl(
                    Uri.parse(
                      'sms:99999999${Platform.isAndroid ? '?' : '&'}body=Message from contact app',
                    ),
                  ),
                ),
              )
            : null),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
