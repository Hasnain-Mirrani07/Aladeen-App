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
              StreamBuilder(
                // stream: FirebaseDatabase.instance
                //     .ref("userData")
                //     .where("email", isEqualTo: searchController.text)// we also store Data  in firestore for executing query filter
                //     .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const ListTile(
                      title: Text("title"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
