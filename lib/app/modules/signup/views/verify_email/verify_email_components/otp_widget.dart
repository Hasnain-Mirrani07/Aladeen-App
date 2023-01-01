// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/colors.dart';

class OtpBoxField extends StatelessWidget {
  final void Function(String)? onCodeChanged;
  const OtpBoxField({super.key, required this.onCodeChanged});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OtpTextField(
          onCodeChanged: onCodeChanged,
          decoration: const InputDecoration(hintText: "-"),
          textStyle: TextStyle(
              color: black39Color,
              fontWeight: FontWeight.w500,
              fontSize: 22.sp),
          borderColor: lightBluishColor,
          numberOfFields: 4,
          fieldWidth: 56.h,
          focusedBorderColor: lightBluishColor,
          borderWidth: 1,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          enabled: true,
          showFieldAsBox: true,
          enabledBorderColor: lightBluishColor,
          fillColor: whitetypeColor,
          obscureText: false,
          margin: EdgeInsets.symmetric(horizontal: 10.w)),
    );
  }
}
