import 'dart:io';
import 'dart:ui';

import 'package:botim_app/app/modules/signup/controllers/signup_controller.dart';
import 'package:botim_app/singaltonClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final DatabaseReference ref = FirebaseDatabase.instance.ref("userData");
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
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
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
                                          ? map['profilePic'].toString() == " "
                                              ? Icon(Icons.person)
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      map['profilePic']
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
                                  child: Icon(
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
                              map['uid'].toString(),
                              map['userName'].toString(),
                            );
                          },
                          child: ReuseRow(
                              leading: Icon(Icons.person),
                              title: "User Name",
                              trailing: map['userName']),
                        ),
                      ),
                      ReuseRow(
                          leading: Icon(Icons.phone),
                          title: "User Name",
                          trailing: map['mobileNo']),
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  ReuseRow(
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
