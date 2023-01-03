import 'package:botim_app/app/modules/home/views/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement SplashController
  FirebaseAuth _auth = FirebaseAuth.instance;
  final count = 0.obs;
  RxDouble opacity = 0.0.obs;
  AnimationController? _controller;
  @override
  void onInit() {
    final user = _auth.currentUser;
    if (user != null) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      );
      _controller!.forward();

      // Future.delayed(const Duration(seconds: 4), () {
      //   Get.offAllNamed(MainTasbihScreen.id);
      // });
      _controller!.addListener(() {
        opacity.value = _controller!.value;

        if (opacity.value >= 1.0) {
          Get.off(const BottomNav());
        }
      });
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      );
      _controller!.forward();

      // Future.delayed(const Duration(seconds: 4), () {
      //   Get.offAllNamed(MainTasbihScreen.id);
      // });
      _controller!.addListener(() {
        opacity.value = _controller!.value;

        if (opacity.value >= 1.0) {
          Get.offAndToNamed(Routes.SIGNUP);
        }
      });
    }

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AnimationController;
  }

  void increment() => count.value++;
}
