import 'dart:html';
import 'dart:ui';

import 'package:botim_app/app/modules/home/views/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final List imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  //final databaseRefPic = FirebaseDatabase.instance.ref('/foldername');
  // final ref = FirebaseStorage.instance.ref('/foldername').child('Bottom_pic');
// no need of the file extension, the name will do fine.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home screen"), actions: [
        GestureDetector(
            onTap: () {
              Get.defaultDialog(
  title: "Dialog Title",
  content: Form(
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: "Field 1"),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Field 2"),
        ),
      ],
    ),
  ),
  cancel: ElevatedButton(child: Text("Cancel")),
  confirm: Ele,
  onConfirm: () {
    // Submit form data
  },
);
            },
            child: Icon(Icons.add)),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: GestureDetector(
              onTap: () {
                controller.signOut();
              },
              child: const Icon(Icons.login_outlined)),
        )
      ]),
      body: Column(
        children: [
          CarouselSlider(
              items: imgList
                  .map((item) => Card(
                        child: Container(
                          child: Center(child: Image.network(item.toString())),
                          color: Colors.white,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                aspectRatio: 16 / 9,
                viewportFraction: .9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: null,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 15,
          ),
          Text(
            "Categories",
            style: GoogleFonts.aBeeZee(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: StreamBuilder(
              stream: databaseRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  List<dynamic> list = [];
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as Map;
                  list = map.values.toList();
                  return ListView.builder(
                      itemCount: snapshot.data?.snapshot.children.length,
                      itemBuilder: (context, index) {
                        //  title: Text(list[index]['title'].toString()),
                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(20),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 30.0,
                              mainAxisSpacing: 30.0,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              print("===....List ==${list[index]}");
                              //  var url = ref.getDownloadURL();
                              //   print("img url====>>>>>$url.");
                              return GridTile(
                                footer: Text(
                                  list[index]['title'].toString(),
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100
                                            .withOpacity(0.8),
                                        spreadRadius: 10,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 7), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 15,
                                    child: Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/social-89c3d.appspot.com/o/foldername167?alt=media&token=6b74685f-85e5-4ad6-b89e-89264c4afb6f",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
