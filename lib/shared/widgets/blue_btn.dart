import 'package:botim_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueBtn extends StatelessWidget {
  bool isLoading;
  final String title;
  final Color color;
  final double Horizentalpading;
  final void Function()? onPressed;
  BlueBtn({
    Key? key,
    this.isLoading = false,
    required this.title,
    this.color = lightBluishColor,
    required this.onPressed,
    this.Horizentalpading = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Horizentalpading.w),
      child: SizedBox(
        height: 47.h,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
            child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        title,
                        style: GoogleFonts.yantramanav(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                        ),
                      ))),
      ),
    );
  }
}
