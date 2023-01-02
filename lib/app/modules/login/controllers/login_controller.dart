import 'package:botim_app/app/modules/home/views/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/custome_snackbar.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

//------signin
  bool isHideText = false;
  String initialCountry = 'SA';

//email validate

  // final emailValidator = MultiValidator(
  //     [EmailValidator(errorText: 'Enter a valid email address')]);

//--pass validate
  RxString email = ''.obs;
  RxString pass = ''.obs;
  void getEmail(value) {
    email.value = value;
  }

  void getPass(value) {
    pass.value = value;
  }

  final requiredValidator = RequiredValidator(errorText: 'Required Field');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Required Field'),
    MaxLengthValidator(20, errorText: 'Maximum password limit'),
    MinLengthValidator(8, errorText: 'Minimum password limit'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Please use special Chracter')
  ]);
  // var outlineInputBorder =
  //     OutlineInputBorder(borderSide: BorderSide(width: 1.w, color: greyColor));
  bool isLoading = false;
  final count = 0.obs;
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

  signIn() async {
    print("Login cal");
    if (formKeyLogin.currentState!.validate()) {
      isLoading = true;
      String noEamil = email.value.toString() + "@gmail.com";
      print("===login email====>>$noEamil");

      try {
        await _auth
            .signInWithEmailAndPassword(
                email: noEamil, password: pass.toString())
            .then((value) {
          isLoading = false;
          Get.to(const BottomNav());
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

//----pass hide
  void ishide() {
    isHideText = !isHideText;
  }

  void increment() => count.value++;
}
