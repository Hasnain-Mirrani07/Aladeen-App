import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  final formKeySignup = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
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

  void increment() => count.value++;
}
