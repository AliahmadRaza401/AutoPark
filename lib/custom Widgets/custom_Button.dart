import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/utils/appColor.dart';

import 'default_Text.dart';

Widget outlineButton(BuildContext context, String name, textColor,
    Function() onPressed, Color borderColor) {
  return SizedBox(
    width: 335.w,
    height: 50.h,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(color: AppColor.primaryColor),
          ),
        ),
      ),
      onPressed: onPressed,
      child: text(
        context,
        name,
        18.sp,
        boldText: "",
        color: textColor,
      ),
    ),
  );
}

Widget elevatedButton(
  BuildContext context,
  String textname,
  Function() onPressed,
) {
  return SizedBox(
    width: 335.w,
    height: 50.h,
    child: ElevatedButton(
        child: text(context, textname, 16.sp,
            boldText: FontWeight.w700, color: AppColor.whiteColor),
        style: TextButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50.r,
            ),
          ),
        ),
        onPressed: onPressed),
  );
}

Widget elevatedButtonwithIcon(BuildContext context, String name,
    Function() onPressed, Color buttonColor, Image icon, Color textColor) {
  return SizedBox(
    width: 335.w,
    height: 50.h,
    child: ElevatedButton.icon(
        label: text(context, name, 14.sp, boldText: "", color: textColor),
        icon: icon,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        onPressed: onPressed),
  );
}
