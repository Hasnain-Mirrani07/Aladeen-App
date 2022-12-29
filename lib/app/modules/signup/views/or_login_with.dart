
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';

class OrLoginWithHeadings extends StatelessWidget {
  const OrLoginWithHeadings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 113.w,
          height: 1.h,
          color: greyColor,
        ),
        SizedBox(
          width: 14.w,
        ),
        Text(
          "or_signup",
          style: TextStyle(
              fontSize: 14.sp, fontWeight: FontWeight.w400, color: greyColor),
        ),
        SizedBox(
          width: 14.w,
        ),
        Container(
          width: 113.w,
          height: 1.h,
          color: greyColor,
        ),
      ],
    );
  }
}
