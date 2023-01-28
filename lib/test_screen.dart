import 'package:botim_app/models/ChatRoomModel.dart';
import 'package:botim_app/models/UserModel.dart';
import 'package:botim_app/singaltonClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'ChatRoomPage.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TestScreen> {
  final searchController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref("userData");
  final firestore = FirebaseFirestore.instance
      .collection("user")
      .where('uid', isNotEqualTo: SessionController().userId.toString())
      .snapshots();
  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  User? firebaseUser;
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search usser",
                ),
              ),
              ElevatedButton(
                child: const Text("Search"),
                onPressed: () {
                  var user = auth.currentUser!.email;
                  setState(() {});
                  print("user=====$user");
                },
              ),
              Expanded(
                child: StreamBuilder(
                    stream: firestore,
                    // stream: FirebaseDatabase.instance
                    //     .ref("userData")
                    //     .where("email", isEqualTo: searchController.text)// we also store Data  in firestore for executing query filter
                    //     .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      QuerySnapshot chatRoomSnapshot =
                          snapshot.data as QuerySnapshot;

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ChatRoomModel? chatRoomModel =
                                ChatRoomModel.fromMap(
                                    chatRoomSnapshot.docs[index].data()
                                        as Map<String, dynamic>);

                            Map<String, dynamic> participants =
                                chatRoomModel.participants!;

                            List<String> participantKeys =
                                participants.keys.toList();
                            participantKeys.remove(userModel!.uid);

                            var filter = snapshot.data!.docs[index]['userEmail']
                                .toString()
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase());

                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatRoomPage(
                                        chatroom: chatRoomModel,
                                        firebaseUser: firebaseUser!,
                                        userModel: userModel!,
                                        targetUser: snapshot.data!.docs[index]
                                            ['uid'],
                                      );
                                    }),
                                  );
                                },
                                leading: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundImage: NetworkImage(snapshot
                                            .data!.docs[index]['profilePic'] ??
                                        ''),
                                  ),
                                ),
                                title: Text(
                                    snapshot.data!.docs[index]['userEmail']),
                                trailing: const Icon(Icons.message),
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
