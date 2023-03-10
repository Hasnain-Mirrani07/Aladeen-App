import 'dart:io';
import 'package:botim_app/app/modules/signup/views/verify_email/verify_number.dart';
import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:botim_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignupController extends GetxController {
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref().child("userData");
  final firestore = FirebaseFirestore.instance.collection("user");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  RxBool isloading = false.obs;
  final formKeySignup = GlobalKey<FormState>();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  RxString name = ''.obs;
  RxString pass = ''.obs;
  void getName(value) {
    name.value = value;
  }

  void getPass(value) {
    pass.value = value;
  }

  final count = 0.obs;
  //signUp
  final phoneNoController = TextEditingController();
  bool isHideText = true;
  RxBool showpass = true.obs;
  RxBool showpassConf = true.obs;
  RxBool isLoading = false.obs;
  String initialCountry = 'SA';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  final requiredValidator = RequiredValidator(errorText: 'Required Field');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Required Field'),
    MaxLengthValidator(20, errorText: 'Maximum password limit'),
    MinLengthValidator(6, errorText: 'Minimum password limit'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Please use special Chracter')
  ]);
  var outlineInputBorder =
      OutlineInputBorder(borderSide: BorderSide(width: 1.w, color: greyColor));

  verifyNo() async {
    print("===>>>Verify Mobile No");

    isLoading = true.obs;
    String noWithCode = "+92${phoneNoController.text}";
    // print("No==>>>${noWithCode}");
    // print("noEmail==${pass.value}");
    _auth.verifyPhoneNumber(
      phoneNumber: noWithCode,
      verificationCompleted: (_) {},
      verificationFailed: (error) {
        customSnackbar("$error", "Veriffy error");
      },
      codeSent: (verificationId, forceResendingToken) {
        Get.to(VerifyNumberScreen(
          verificationId: verificationId,
          VerificationToken: forceResendingToken,
        ));
      },
      codeAutoRetrievalTimeout: (e) {
        customSnackbar(e.toString(), "Error");
      },
    );
  }

  void creatAccount() async {
    isloading.value = true;
    try {
      String noEamil = "${phoneNoController.text}@gmail.com";
      await _auth
          .createUserWithEmailAndPassword(
              email: noEamil, password: pass.toString())
          .then((value) async {
        //--Sava data to FirevaseDatabase
        final uid = value.user!.uid.toString();
        final userEmail = value.user!.email.toString();
        final no = phoneNoController.text.toString();
        var imgurl = '';
        print("$name = $no $userEmail = $uid  ");

//----Image upload-----
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/foldername$uid');
        firebase_storage.UploadTask uploadTask = ref.putFile(imagef!.absolute);
        await Future.value(uploadTask).then((value) async {
          imgurl = await ref.getDownloadURL();
        });

//----All Data Added to Database----

        firestore.doc(value.user!.uid.toString()).set({
          "uid": value.user!.uid.toString(),
          "userName": name.toString(),
          "userEmail": value.user!.email.toString(),
          "mobileNo": phoneNoController.text.toString(),
          "profilePic": imgurl,
          "online": "false"
        }).then((value) {
          isLoading.value = false;
          customSnackbar("Successfully", "User Added");
        }).onError((error, stackTrace) {
          isLoading.value = false;
          customSnackbar("Data not added ", "$error");
        });
        customSnackbar("email pass Added", "Auth call");

        Get.toNamed(Routes.LOGIN);
      }).onError((error, stackTrace) => customSnackbar("Auth error", "$error"));
    } catch (e) {
      customSnackbar("Try Catch Error", "Email or Password is wrong");
    }
  }
  //verify otp
//git ripositry

  void ishideConf() {
    showpassConf.toggle();
  }

  void ishide() {
    showpass.toggle();
    print("show pass=>$showpass");
  }

  //--------------------------------------------------------------
  File? imagef;
  void imgFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (imagef != null) {
      imagef = File(image!.path);
      update();
    } else {
      customSnackbar("image is Empaty", "message");
    }
  }

  //--------------------------------------------------------------
  void imgFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    imagef = File(image.path);
    update();
  }

  void cancelImg() {
    imagef = null;
    update();
  }

//----img picker
  Widget addImgBtn(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.only(
        left: 4.w,
        right: 5.w,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (imagef == null) {
                _showImagePickerSheet(context);
              } else {
                imagef = null;
              }
              update();
            },
            child: Container(
              height: 77.h,
              width: 80.w,
              decoration: const BoxDecoration(
                  color: Colors.lightBlue, shape: BoxShape.circle),
              child: const Icon(
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

  void _showImagePickerSheet(context) {
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
  var category = ''.obs;
  void getCategory(category) {
    category.value = category;
  }

  // void addCategory() async {
  //   DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  //   print("pres");
  //   try {
  //     var id = DateTime.now().millisecond.toString();
  //     firebase_storage.Reference ref =
  //         firebase_storage.FirebaseStorage.instance.ref('/foldername' + id);
  //     firebase_storage.UploadTask uploadTask = ref.putFile(imagef!.absolute);
  //     await Future.value(uploadTask).then((value) async {
  //       var newurl = await ref.getDownloadURL();
  //       print("Data in category=> $id $newurl ${category.value}");
  //       databaseRef.child(id).set({'id': id, 'title': newurl.toString()});
  //       // databaseRef.child("category").child(id).set({
  //       //   'id': id,
  //       //   'categoryName': categoryController.text.toString(),
  //       //   'imgurl': newurl.toString()
  //       // });
  //       print("upload");
  //     });
  //   } catch (e) {
  //     return customSnackbar("Category Added", "Successfully");
  //   }
  // }

}
