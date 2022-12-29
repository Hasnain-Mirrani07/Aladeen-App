import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/custome_snackbar.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final formKey = GlobalKey<FormState>();
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

  signIn() async {
    print("sigup call");
    if (formKey.currentState!.validate()) {
      isLoading = true;

      try {
        await _auth
            .signInWithEmailAndPassword(
                email: nameController.text.toString(),
                password: passwordController.text.toString())
            .then((value) {
          isLoading = false;
          Get.toNamed(Routes.HOME);
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
