import 'package:botim_app/app/modules/home/bindings/home_binding.dart';
import 'package:botim_app/app/modules/home/controllers/home_controller.dart';
import 'package:botim_app/app/modules/home/views/home_view.dart';
import 'package:botim_app/app/modules/login/controllers/login_controller.dart';
import 'package:botim_app/app/modules/login/views/login_view.dart';
import 'package:botim_app/app/modules/signup/controllers/signup_controller.dart';
import 'package:botim_app/app/modules/signup/views/signup_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final loginController = Get.put(LoginController());
    final signupController = Get.put(SignupController());

    return Obx(
      () => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: const <Widget>[
            Icon(Icons.home_outlined, size: 30),
            FaIcon(FontAwesomeIcons.fileCircleQuestion),
            Icon(Icons.person_pin_circle_outlined, size: 30),
            Icon(Icons.person_outline, size: 30),
          ],
          onTap: (index) {
            controller.indexchange(index);
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(child: controller.bodyPage[controller.page.value]),
        ),
      ),
    );
  }
}
