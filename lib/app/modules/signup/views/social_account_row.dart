import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/assets.dart';

class SocailAccountRow extends StatelessWidget {
  const SocailAccountRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Image.asset(
            fbLogo,
            width: 25.w,
            height: 25.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          child: Image.asset(
            googleLogo,
            width: 25.w,
            height: 25.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          child: Image.asset(
            appleIcon,
            width: 25.w,
            height: 25.w,
          ),
        )
      ],
    );
  }
}
