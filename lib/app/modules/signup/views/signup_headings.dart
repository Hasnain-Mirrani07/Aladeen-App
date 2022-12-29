
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';

class AboveHeadings extends StatelessWidget {
  const AboveHeadings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 15.sp),
          children: [
            TextSpan(
                text: 'welcm_expert',
                style: GoogleFonts.yantramanav(
                  color: greyColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                )),
            TextSpan(
                text: '${'tutorials'}.',
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: GoogleFonts.yantramanav(
                  color: lightBluishColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
        //textScaleFactor: 0.5,
      ),
    );
  }
}
