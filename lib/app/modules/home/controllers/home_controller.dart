import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    try {
      _auth.signOut().then((value) {
        Get.toNamed(Routes.LOGIN);
        customSuccessSnackbar("Logout", "Succfully Logout");
      });
    } catch (e) {
      customSnackbar("Error", "Not logout yet");
    }
  }
  //TODO: Implement HomeController

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

  void increment() => count.value++;
}
