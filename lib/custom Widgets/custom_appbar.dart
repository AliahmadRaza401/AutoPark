import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/AppColor.dart';

import 'package:parkingapp/utils/appStyle.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

Widget customAppBar(context, title) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
    ),
    child: Row(
      children: [
        SvgPicture.asset(
          'assets/svg/s_logo.svg',
          height: 30,
          width: 40,
        ),
        SizedBox(
          width: dynamicWidth(context, 0.04),
        ),
        Text(
          title,
          style: AppStyle.headingBold,
        ),
      ],
    ),
  );
}

Widget customAppBarWithBack(context, title) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColor.primaryColor),
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        Text(
          title,
          style: AppStyle.headingBold,
        ),
        SizedBox(
          width: dynamicWidth(context, 0.1),
        ),
      ],
    ),
  );
}
