// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImgContainer extends StatelessWidget {
  final String imgPath;
  final double widthC;
  final double heightC;

  const ImgContainer({
    super.key,
    required this.imgPath,
    required this.widthC,
    required this.heightC,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: heightC,
        width: widthC,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.fill),
          // image:  DecorationImage(
          // image: SvgPicture.asset('images/example.svg',),
          //  fit: BoxFit.fill,
        ));
  }
}
