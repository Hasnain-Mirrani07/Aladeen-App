import 'package:botim_app/singaltonClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search user",
                ),
              ),
              ElevatedButton(
                child: const Text("Search"),
                onPressed: () {
                  var user = auth.currentUser!.email;
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
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (searchController.text == null) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: ListTile(
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
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: ListTile(
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
