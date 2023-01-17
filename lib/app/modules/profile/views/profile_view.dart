import 'dart:io';

import 'package:botim_app/singaltonClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final DatabaseReference ref = FirebaseDatabase.instance.ref("userData");
  final firestore = FirebaseFirestore.instance
      .collection("user")
      .doc(SessionController().userId.toString())
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'ProfileView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: firestore,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  //   Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                  return Column(
                    children: [
                      Center(
                          child: Stack(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GetBuilder<ProfileController>(
                                  init: ProfileController(),
                                  builder: (controllerP) => Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: controllerP.imagef == null
                                          ? snapshot.data['profilePic']
                                                      .toString() ==
                                                  " "
                                              ? const Icon(Icons.person)
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data['profilePic']
                                                      .toString()),
                                                )
                                          : Image.file(
                                              File(controllerP.imagef!.path)
                                                  .absolute,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                )
                              ]),
                          Positioned(
                              top: 50,
                              right: 185,
                              child: GetBuilder<ProfileController>(
                                init: ProfileController(),
                                builder: (controllerP) => GestureDetector(
                                  onTap: () {
                                    print("button");
                                    controllerP.showImagePickerSheet(context);
                                  },
                                  child: const Icon(
                                    Icons.add_a_photo,
                                  ),
                                ),
                              )),
                        ],
                      )),
                      GetBuilder(
                        init: ProfileController(),
                        builder: (controllerp) => GestureDetector(
                          onTap: () {
                            controllerp.cstmshowDialog(
                              snapshot.data['uid'].toString(),
                              snapshot.data['userName'].toString(),
                            );
                          },
                          child: ReuseRow(
                              leading: const Icon(Icons.person),
                              title: "User Name",
                              trailing: snapshot.data['userName']),
                        ),
                      ),
                      ReuseRow(
                          leading: const Icon(Icons.phone),
                          title: "User Name",
                          trailing: snapshot.data['mobileNo']),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  const ReuseRow(
      {super.key,
      required this.leading,
      required this.title,
      required this.trailing});
  final String title;
  final trailing;
  final leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title.toString()),
      trailing: Text(trailing.toString()),
    );
  }
}
