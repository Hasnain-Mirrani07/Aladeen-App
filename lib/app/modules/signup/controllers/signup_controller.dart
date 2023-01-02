import 'dart:io';
import 'package:botim_app/app/modules/signup/views/verify_email/verify_number.dart';
import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:botim_app/utils/assets.dart';
import 'package:botim_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  final formKeySignup = GlobalKey<FormState>();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  RxString email = ''.obs;
  RxString pass = ''.obs;
  void getEmail(value) {
    email.value = value;
  }

  void getPass(value) {
    pass.value = value;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
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

  verifyNo() async {
    print("sigup call");

    if (formKeySignup.currentState!.validate()) {
      isLoading = true.obs;
      String noWithCode = "+92" + phoneNoController.text.toString();
      print("No==>>>${noWithCode}");
      _auth.verifyPhoneNumber(
        phoneNumber: noWithCode,
        verificationCompleted: (_) {},
        verificationFailed: (error) {
          customSnackbar("$error", "Verify error");
        },
        codeSent: (verificationId, forceResendingToken) {
          Get.to(VerifyNumberScreen(
            verificationId: verificationId,
            VerificationToken: forceResendingToken,
          ));
        },
        codeAutoRetrievalTimeout: (e) {
          customSnackbar("$e", "codeAutoRetrievalTimeout");
        },
      );
    } else {
      customSnackbar("Validation error", "Email or Password is wrong");
    }
  }

  void creatAccount() async {
    try {
      String noEamil = phoneNoController.text.toString() + "@gmail.com";
      print("noEmail=======>>>$noEamil");
      print("noEmail==${pass.value}=====>>>${email.value}");
      await _auth
          .createUserWithEmailAndPassword(
              email: noEamil, password: pass.toString())
          .then((value) {
        Get.toNamed(Routes.LOGIN);

        customSnackbar("Succfully", "Signup");
      });
    } catch (e) {
      customSnackbar("Sorry", "Email or Password is wrong");
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

    imagef = File(image!.path);
    update();
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
                _showImagePickerSheet(context);
              } else {
                imagef = null;
              }
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

//drop down menu
//list drop down
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  RxString selectedValue = "USA".obs;

  void changeDrowpDownValue(value) {
    selectedValue.value = value;
  }

  //save record of creat account

}
