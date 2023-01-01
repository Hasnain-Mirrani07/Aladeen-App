// ignore_for_file: prefer_const_constructors

import 'package:botim_app/app/modules/signup/controllers/signup_controller.dart';
import 'package:botim_app/app/modules/signup/views/verify_email/verify_email_components/otp_widget.dart';
import 'package:botim_app/app/routes/app_pages.dart';
import 'package:botim_app/shared/widgets/cstm_text_field.dart';
import 'package:botim_app/shared/widgets/custome_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../shared/widgets/blue_btn.dart';
import '../../../../../shared/widgets/img_container.dart';
import '../../../../../utils/assets.dart';
import '../../../../../utils/colors.dart';

class VerifyNumberScreen extends StatefulWidget {
  static const id = '/VerifyEmail';
  VerifyNumberScreen(
      {super.key,
      required this.verificationId,
      required this.VerificationToken});
  var verificationId;
  var VerificationToken;

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  var otp;
  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<SignupController>().verifyNo();
    //var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 34.h,
                  ),
                  Row(children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: blackkColor,
                      ),
                    ),
                    SizedBox(
                      width: 18.h,
                    ),
                    Text(
                      'Verify Your Phone Number',
                      style: GoogleFonts.yantramanav(
                        color: blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 68.h,
                  ),
                  Center(
                    child: ImgContainer(
                      imgPath: verifyEmail,
                      heightC: 120.h,
                      widthC: 116.w,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Text(
                      textAlign: TextAlign.center,
                      '6 Digit Verification Code',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: blackColor),
                    ),
                  ),
                  SizedBox(
                    height: 68.h,
                  ),
                  // OtpBoxField(
                  //   onCodeChanged: (value) {
                  //     otp = value;
                  //     setState(() {});
                  //   },
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CstmTextFieldTemplate(
                      onChanged: (value) {
                        otp = value;
                        setState(() {});
                      },
                      validator: null,
                      hintText: 'Verification Code',
                      labelText: 'Verification Code',
                      isPassword: false,
                      keyboardType: TextInputType.text,
                      isBorder: false,
                    ),
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  Center(
                    child: Text(
                      'Don not Recivied Code',
                      style: GoogleFonts.yantramanav(
                        color: blackkColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: null,
                    splashColor: lightBluishColor,
                    child: Center(
                      child: Text('Resend',
                          style: GoogleFonts.yantramanav(
                              color: lightBluishColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline)),
                    ),
                  ),
                  SizedBox(height: 119.h),
                  SizedBox(
                    height: 45,
                    child: BlueBtn(
                      Horizentalpading: 1.0,
                      title: 'verify',
                      onPressed: () async {
                        print("otp ==>>$otp");
                        final credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId.toString(),
                            smsCode: otp.toString());
                        try {
                          await _auth.signInWithCredential(credential);
                          _controller;
                          Get.toNamed(Routes.LOGIN);
                        } catch (e) {
                          customSnackbar(
                              "Verification Code Error", "Please Try Again");
                        }
                        setState(() {});
                      },
                      //  ReUse().goToCreatNewPasswordScreen(context),
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
