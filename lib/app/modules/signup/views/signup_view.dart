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
  SignupView({Key? key}) : super(key: key);
  final _formKeySignup = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKeySignup,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Obx(
              () => Stack(
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
                        GetBuilder<SignupController>(
                          builder: (controller) => Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                controller.imagef != null
                                    ? Stack(
                                        //  clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            width: 77.w,
                                            height: 80.w,
                                            // padding: EdgeInsets.only(
                                            //     left: 4.w, right: 5.w, top: 5.h, bottom: 6.h),
                                            decoration: BoxDecoration(
                                              //  borderRadius: BorderRadius.circular(5.r),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: FileImage(
                                                  controller.imagef!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: -.1.w,
                                            top: -.1.h,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red[50],
                                                shape: BoxShape.circle,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.cancelImg();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : controller.addImgBtn(context),
                                SizedBox(
                                  width: 20.w,
                                ),
                              ],
                            ),
                          ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: CstmTextFieldTemplate(
                            onChanged: (name) {
                              controller.getName(name);
                            },
                            validator: controller.requiredValidator,
                            hintText: 'Enter Full Name',
                            labelText: 'Full Name',
                            isPassword: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),

                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: CstmTextFieldTemplate(
                            onChanged: (pass) {
                              controller.getPass(pass);
                              print(pass);
                            },
                            validator: controller.passwordValidator,
                            hintText: 'password',
                            labelText: 'password',
                            isPassword: true,
                            onTap: () => controller.ishide(),
                            showpass: controller.showpass.value,
                            keyboardType: TextInputType.text,
                            hideText: controller.showpass.value,
                          ),
                        ),

                        SizedBox(
                          height: 15.h,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                        //   child: CstmTextFieldTemplate(
                        //     validator: controller.passwordValidator,
                        //     hintText: 'Confirm password',
                        //     labelText: 'Confirm password',
                        //     isPassword: true,
                        //     onTap: () => controller.ishideConf(),
                        //     showpass: controller.showpassConf.value,
                        //     keyboardType: TextInputType.text,
                        //     hideText: controller.showpassConf.value,
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
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 24.w),
                        //     child: DropdownButtonFormField(
                        //         decoration: InputDecoration(
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(
                        //                 color: Colors.blue, width: 2),
                        //             borderRadius: BorderRadius.circular(20),
                        //           ),
                        //           border: OutlineInputBorder(
                        //             borderSide: BorderSide(
                        //                 color: Colors.blue, width: 2),
                        //             borderRadius: BorderRadius.circular(20),
                        //           ),
                        //           //  filled: true,
                        //           // fillColor: Colors.blueAccent,
                        //         ),
                        //         // dropdownColor: Colors.blueAccent,
                        //         value: controller.selectedValue.value,
                        //         onChanged: (newValue) {
                        //           controller.changeDrowpDownValue(newValue);
                        //         },
                        //         items: controller.dropdownItems),

                        //     // child: CstmTextFieldTemplate(
                        //     //   validator: controller.requiredValidator,
                        //     //   hintText: 'Location',
                        //     //   labelText: 'Location',
                        //     //   hideText: false,
                        //     //   isPassword: false,
                        //     // ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 15.h,
                        ),

                        BlueBtn(
                            isLoading: controller.isLoading.value,
                            title: 'Sign up',
                            color: lightBluishColor,
                            onPressed: () {
                              if (_formKeySignup.currentState!.validate()) {
                                controller.creatAccount();
                              }

                              //controller.verifyNo();
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
        ));
  }
}
