import 'package:botim_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AlreadyAccount extends StatelessWidget {
  const AlreadyAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Account",
          style: TextStyle(
            color: blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
            onTap: () {},
            child: Text(
              "log_in",
              style: GoogleFonts.yantramanav(
                color: lightBluishColor,
                fontWeight: FontWeight.w500,
              ),
            )),
      ],
    );
  }
}
