import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/blue_btn.dart';
import '../../../../shared/widgets/cstm_text_field.dart';
import '../../../../utils/assets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../../signup/views/social_account_row.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final formKeyLogin = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKeyLogin,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Positioned(
                top: 15.h,
                left: 0.0,
                child: Image.asset(
                  leftSideHook,
                  opacity: const AlwaysStoppedAnimation<double>(0.15),
                  height: 142.h,
                ),
              ),
              Positioned(
                top: 50.h,
                right: 0.0,
                child: Image.asset(
                  rightSideHook,
                  opacity: const AlwaysStoppedAnimation<double>(0.15),
                  height: 256.h,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                      child: Image.asset(
                        logoImg,
                        width: 73.w,
                        height: 74.h,
                      ),
                    ),
                    Text(
                      "Test App",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 23.w),
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "sign_in",
                        style: TextStyle(
                          color: blackColor,
                          letterSpacing: 0.02,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: RichText(
                        text: TextSpan(
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                          children: [
                            TextSpan(
                                text: 'welcm_expert',
                                style: GoogleFonts.yantramanav(
                                  color: greyColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            TextSpan(
                                text: 'tutorials',
                                // recognizer: GestureDetector()
                                //   ..onTap = () {},
                                style: GoogleFonts.yantramanav(
                                  color: lightBluishColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        //textScaleFactor: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: CstmTextFieldTemplate(
                        onChanged: (_email) {
                          controller.getEmail(_email);
                        },
                        hintText: "enter_email",
                        labelText: 'email_addres',
                        validator: controller.requiredValidator,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: CstmTextFieldTemplate(
                        validator: controller.passwordValidator,
                        onChanged: (_pass) {
                          controller.getPass(_pass);
                        },
                        hintText: 'password',
                        labelText: 'password',
                        //   showSuffixIcon: true,
                        hideText: controller.isHideText,
                        onTap: () {
                          controller.ishide();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18.w, right: 24.w),
                      child: Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text(
                            "Remember me",
                            style: GoogleFonts.yantramanav(
                              color: blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                // ReUse().goToCreatNewPasswordScreen(context);
                              },
                              child: GestureDetector(
                                onTap: () => null,
                                // reUse.goToForgetPasswordScreen(context),
                                child: Text(
                                  'Forget Password',
                                  style: GoogleFonts.yantramanav(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: blackColor),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    BlueBtn(
                      title: 'login',
                      color: lightBluishColor,
                      onPressed: () {
                        if (formKeyLogin.currentState!.validate()) {
                          controller.signIn();
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    _loginWithHeadings(),
                    SizedBox(
                      height: 21.h,
                    ),
                    const SocailAccountRow(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${'Not Account'}  ",
                          style: GoogleFonts.yantramanav(
                            color: blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: Text(
                              "register",
                              style: GoogleFonts.yantramanav(
                                color: lightBluishColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginWithHeadings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              //width: 113.w,
              height: 1.h,
              color: greyColor,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "or Login",
            style: TextStyle(
                fontSize: 14.sp, fontWeight: FontWeight.w400, color: greyColor),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Container(
              width: 113.w,
              height: 1.h,
              color: greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
