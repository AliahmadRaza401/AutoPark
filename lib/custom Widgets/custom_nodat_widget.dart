import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget noDataWidget(BuildContext context, ) {
  return SizedBox(
      // width: 335.w,
      height: MediaQuery.of(context).size.height,
      child: Lottie.asset('assets/jsonFiles/noData.json',
          animate: true,
          repeat: true,
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width));
}
