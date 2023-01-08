import 'dart:io';
import 'package:botim_app/singaltonClass.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../shared/widgets/custome_snackbar.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final DatabaseReference dataref = FirebaseDatabase.instance.ref("userData");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;

  final count = 0.obs;

  get lightBluishColor => null;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  XFile? imagef;
  void imgFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (imagef != null) {
      imagef = XFile(image!.path);
      uploadImage();
      update();
    } else {
      customSnackbar("image is Empaty", "message");
    }
  }

  //--------------------------------------------------------------
  void imgFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagef = XFile(image.path);
      uploadImage();
      update();
    }
  }

  void cancelImg() {
    imagef = null;
    update();
  }

  var a = "variable";
//----img picker
  Widget addImgBtn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.only(
        left: 4.w,
        right: 5.w,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (imagef == null) {
                showImagePickerSheet(context);
              } else {
                imagef = null;
              }
              print("button of bottom sheet");
              update();
            },
            child: Container(
              height: 77.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Colors.lightBlue, shape: BoxShape.circle),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 21,
              ),
              // child: ElevatedButton(
              //   style: ButtonStyle(
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(5.0),
              //             side: BorderSide(color: Colors.transparent))),
              //     backgroundColor: MaterialStateProperty.all(
              //       _image == null ? Colors.transparent : Colors.transparent,
              //     ),
              //   ),
              //   onPressed: () {
              //     if (_image == null) {
              //       _showImagePickerSheet(context);
              //     } else {
              //       setState(() {
              //         _image = null;
              //       });
              //     }
              //   },
              //   // child: Column(
              //   //   children: [
              //   //     SizedBox(
              //   //       height: 5.h,
              //   //     ),
              //   //     // Icon(
              //   //     //   Icons.add,
              //   //     //   color: lightBluishColor,
              //   //     //   size: 24.0,
              //   //     // ),
              //   //     // Text(
              //   //     //   "add_img",
              //   //     //   style: GoogleFonts.inter(
              //   //     //       fontWeight: FontWeight.w400,
              //   //     //       fontSize: 11.sp,
              //   //     //       color: _image != null ? whiteColor : lightBluishColor),
              //   //     // ),

              //   //     SizedBox(
              //   //       height: 5.h,
              //   //     )
              //   //     // const FittedBox(
              //   //     //     fit: BoxFit.contain, child: Text("(Optional)"))
              //   //   ],
              //   // ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

//image sheet

  void showImagePickerSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            // decoration: const BoxDecoration(
            //   color: Colors.white,
            // ),
            height: 125.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Photo',
                  style: TextStyle(
                      color: lightBluishColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    _galleryBtn(context),
                    SizedBox(
                      width: 20.h,
                    ),
                    _cameraPickerBtn(context),
                  ],
                )
              ],
            ),
          );
        });
  }

//galary camra camra piker
  GestureDetector _galleryBtn(context) {
    return GestureDetector(
      onTap: () {
        imgFromGallery();
        update();
        //_uploadFile();
        Navigator.pop(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.photo,
            size: 30.sp,
            color: lightBluishColor,
          ),
          Text(
            'Gallery',
            style: TextStyle(
              color: lightBluishColor,
              fontSize: 18.sp,
            ),
          )
        ],
      ),
    );
  }

  //--------------------------------------------------------------
  GestureDetector _cameraPickerBtn(context) {
    return GestureDetector(
      onTap: () {
        imgFromCamera();

        Navigator.pop(context);
        update();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.camera_alt,
            size: 30.sp,
            color: lightBluishColor,
          ),
          Text(
            'Camera',
            style: TextStyle(
              color: lightBluishColor,
              fontSize: 18.sp,
            ),
          )
        ],
      ),
    );
  }

  RxString selectedValue = "USA".obs;

  void changeDrowpDownValue(value) {
    selectedValue.value = value;
  }

  //save record of creat account

  //add category
  // var category = ''.obs;
  // void uploadImage(category) {
  //   category.value = category;
  // }

  void uploadImage() async {
    print("pres");
    try {
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref('/folder');
      firebase_storage.UploadTask uploadTask =
          storageRef.putFile(File(imagef!.path).absolute);
      await Future.value(uploadTask).then((value) async {
        var newurl = await storageRef.getDownloadURL();
        print("Data in category=> $newurl");
        dataref
            .child(SessionController().userId.toString())
            .update({"profilePic": newurl})
            .then((value) => customSnackbar("profile updated", "Successfully"))
            .onError((error, stackTrace) =>
                customSnackbar("Sorry", "profile not updated"));
        // databaseRef.child("category").child(id).set({
        //   'id': id,
        //   'categoryName': categoryController.text.toString(),
        //   'imgurl': newurl.toString()
        // });
        //       print("upload");
      }).then((value) => customSnackbar("uplaod error", "$value"));
    } catch (e) {
      return customSnackbar("try catch", "$e");
    }
  }
}
