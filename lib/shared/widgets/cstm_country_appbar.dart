import 'package:botim_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CstmCountryAppBar extends StatelessWidget {
  final String title;

  String countryName;
  CstmCountryAppBar({Key? key, this.title = '', this.countryName = 'Austraila'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  fontSize: 18.sp,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    countryName,
                    style: GoogleFonts.yantramanav(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.expand_more,
                    color: Colors.grey,
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          _serachIcon(context),
        ],
      ),
    );
  }

  Widget _serachIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("search icon pressed");
      },
      child: Container(
        margin: EdgeInsets.only(right: 24.w),
        padding: EdgeInsetsDirectional.only(
          end: 11.h,
          start: 11.h,
          top: 10.h,
          bottom: 10.h,
        ),
        decoration: BoxDecoration(
          color: lightBluishColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: whiteColor,
              size: 30,
            ),
            SizedBox(
              width: 18.4.w,
            ),
            Container(
              width: 27.w,
              height: 27.w,
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.w,
                    color: whiteColor,
                  )),
            ),
            SizedBox(
              width: 8.w,
            )
          ],
        ),
      ),
    );
  }
}
