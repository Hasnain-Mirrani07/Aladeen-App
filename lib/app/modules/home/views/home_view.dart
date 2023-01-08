import 'dart:ui';

import 'package:botim_app/app/modules/home/views/drawer.dart';
import 'package:botim_app/app/modules/home/views/navbar.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../signup/controllers/signup_controller.dart';
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
  //final databaseRefPic = FirebaseDatabase.instance.ref('/foldername');
  // final ref = FirebaseStorage.instance.ref('/foldername').child('Bottom_pic');
// no need of the file extension, the name will do fine.
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyHomePage(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text("Home screen"),
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
            actions: [
              //  addCategory(context),
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
                            child:
                                Center(child: Image.network(item.toString())),
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
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: imgList.length,
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
                          itemCount: imgList.length,
                          itemBuilder: (context, index) {
                            //   print("===....List ==${list[index]}");
                            //  var url = ref.getDownloadURL();
                            //   print("img url====>>>>>$url.");
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade100.withOpacity(0.8),
                                    spreadRadius: 10,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 7), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Card(
                                elevation: 15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "${imgList[index]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  Widget addCategory(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controllerSignup) => GestureDetector(
          onTap: () {
            Get.defaultDialog(
              title: "Add category",
              content: Form(
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controllerSignup.imagef != null
                              ? Stack(
                                  //  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 77.w,
                                      height: 80.w,
                                      // padding: EdgeInsets.only(
                                      //     left: 4.w, right: 5.w, top: 5.h, bottom: 6.h),
                                      decoration: BoxDecoration(
                                        //  borderRadius: BorderRadius.circular(5.r),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: FileImage(
                                            controllerSignup.imagef!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -.1.w,
                                      top: -.1.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red[50],
                                          shape: BoxShape.circle,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            controllerSignup.cancelImg();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : controllerSignup.addImgBtn(context),
                          SizedBox(
                            width: 20.w,
                          ),
                        ],
                      ),
                    ),

                    TextFormField(
                      onChanged: null,
                      decoration:
                          InputDecoration(labelText: "Add Category Name"),
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: "Field 2"),
                    // ),
                  ],
                ),
              ),
              cancel: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel")),
              confirm: ElevatedButton(
                onPressed: () {
                  print("on pres call");
                },
                child: Text("Confirm"),
              ),
              onConfirm: () async {
                print("on confirm ");
                //  controllerSignup.addCategory();
              },
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
