import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:botim_app/test_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';

import '../../../../singaltonClass.dart';
import '../../login/views/login_view.dart';
import '../../signup/views/signup_view.dart';
import '../views/home_view.dart';

class HomeController extends GetxController {
  final firebase_storage.FirebaseStorage firebasestorage =
      firebase_storage.FirebaseStorage.instance;

  var page = 0.obs;

  void indexchange(navIndex) {
    page.value = navIndex;
  }

  List bodyPage = [
    HomeView(),
    LoginView(),
    SignupView(),
    const TestScreen(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    try {
      _auth.signOut().then((value) {
        SessionController().userId = "";

        Get.toNamed(Routes.LOGIN);
        customSuccessSnackbar("Logout", "Succfully Logout");
      });
    } catch (e) {
      customSnackbar("Error", "Not logout yet");
    }
  }

  //add category

  //TODO: Implement HomeController

  final count = 0.obs;
}
