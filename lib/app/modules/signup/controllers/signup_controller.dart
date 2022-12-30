import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:botim_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  final formKeySignup = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  final count = 0.obs;

  //signUp
  final phoneNoController = TextEditingController();
  bool isHideText = true;
  RxBool showpass = true.obs;
  RxBool showpassConf = true.obs;

  String initialCountry = 'SA';
  PhoneNumber number = PhoneNumber(isoCode: 'AE');
  final requiredValidator = RequiredValidator(errorText: 'Required Field');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Required Field'),
    MaxLengthValidator(20, errorText: 'Maximum password limit'),
    MinLengthValidator(8, errorText: 'Minimum password limit'),
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

  signUp() async {
    print("sigup call");
    if (formKeySignup.currentState!.validate()) {
      isLoading = true;

      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: nameController.text.toString(),
                password: passwordController.text.toString())
            .then((value) {
          isLoading = false;
          Get.toNamed(Routes.LOGIN);
          customSnackbar("Succfully", "Signup");
        });
      } catch (e) {
        isLoading = false;
        customSnackbar("Sorry", "Email or Password is wrong");
      }
    } else {
      customSnackbar("Server error", "Email or Password is wrong");
    }
  }

  void ishideConf() {
    showpassConf.toggle();
  }

  void ishide() {
    showpass.toggle();
    print("show pass=>$showpass");
  }

  void increment() => count.value++;
}
