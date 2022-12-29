import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home screen"), actions: [
        GestureDetector(
            onTap: () {
              controller.signOut();
            },
            child: const Icon(Icons.login_outlined))
      ]),
      body: Column(
        children: [
          Center(
            child: const Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            child: Text("dialog"),
            onPressed: () {
              AlertDialog(
                title: Text('Welcome'), // To display the title it is optional
                content: Text(
                    'GeeksforGeeks'), // Message which will be pop up on the screen
                // Action widget which will provide the user to acknowledge the choice
                actions: [
                  ElevatedButton(
                    // FlatButton widget is used to make a text to work like a button

                    onPressed:
                        () {}, // function used to perform after pressing the button
                    child: Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('ACCEPT'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
