import 'package:botim_app/app/modules/signup/views/alreadyaccount.dart';
import 'package:botim_app/app/modules/signup/views/or_login_with.dart';
import 'package:botim_app/app/modules/signup/views/social_account_row.dart';
import 'package:botim_app/utils/assets.dart';
import 'package:botim_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../shared/widgets/blue_btn.dart';
import '../../../../shared/widgets/cstm_text_field.dart';
import '../../../../shared/widgets/phone_no_textfield.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeySignup,
      child: SafeArea(
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
                    // Center(
                    //   child: Image.asset(
                    //     splash,
                    //     width: 73.w,
                    //     height: 74.h,
                    //   ),
                    // ),
                    Text(
                      "Aladeen",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 23.w),
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Creater Account",
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
                    // const AboveHeadings(),
                    SizedBox(
                      height: 31.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                    //   child: CstmTextFieldTemplate(
                    //     validator: controller.requiredValidator,
                    //     hintText: 'Enter Email',
                    //     labelText: 'Email Adress',
                    //   ),
                    // ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: PhoneNoTextField(
                          validator: controller.requiredValidator,
                          number: controller.number,
                          outlineInputBorder: controller.outlineInputBorder,
                          controller: controller.phoneNoController),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: CstmTextFieldTemplate(
                        validator: controller.passwordValidator,
                        hintText: 'password',
                        labelText: 'password',
                        hideText: true,
                        isPassword: true,
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    BlueBtn(
                        title: 'Sign up',
                        color: lightBluishColor,
                        onPressed: () {
                          controller.signUp();
                        }),
                    SizedBox(
                      height: 21.h,
                    ),
                    const OrLoginWithHeadings(),
                    SizedBox(
                      height: 21.h,
                    ),
                    const SocailAccountRow(),
                    SizedBox(
                      height: 15.h,
                    ),
                    const AlreadyAccount(),
                    SizedBox(
                      height: 10.h,
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
}
