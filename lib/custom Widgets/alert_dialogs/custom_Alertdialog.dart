//  Call Alert Dialog________________________________________________
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

import '../../All Screens/chose Screen/choseScreen.dart';
import '../../All Screens/singIn/signIn.dart';
import '../../routes/app_Routes.dart';
import '../../utils/appColor.dart';

cDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            width: 500.w,
            // height: 200.h,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightBox(context, 0.01),
                  SizedBox(
                    height: 100.h,
                    width: 500.w,
                    child: Lottie.asset(
                      'assets/jsonFiles/successful.json',
                      animate: true,
                      repeat: true,
                      fit: BoxFit.cover,
                      height: 100.h,
                      width: 500.w,
                    ),
                  ),
                  heightBox(context, 0.06),
                  text(
                    context,
                    'Parking',
                    20.sp,
                    color: AppColor.blackColor,
                    boldText: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void showCustomDialog(
  BuildContext context,
  String title,
  String message,
  image,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 100.h,
                width: dynamicWidth(context, 0.6),
                child: Lottie.asset(
                  image,
                  animate: true,
                  repeat: true,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 500.w,
                ),
              ),
              SizedBox(
                height: 55.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontFamily: "Poppins",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 8.h,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: message,
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontFamily: "Poppins",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ])),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  AppRoutes.pushAndRemoveUntil(
                      context, PageTransitionType.bottomToTop, const ChoseScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                  width: 150.w,
                  height: 55.h,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text(
                          context,
                          'Done',
                          22.sp,
                          boldText: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showNoLoginCustomDialog(
  BuildContext context,
  String title,
  String message,
  image,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 100.h,
                width: dynamicWidth(context, 0.3),
                child: Lottie.asset(
                  image,
                  animate: true,
                  repeat: true,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 500.w,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontFamily: "Poppins",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 8.h,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: message,
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontFamily: "Poppins",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ])),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  AppRoutes.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                  width: 150.w,
                  height: 55.h,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text(
                          context,
                          'Done',
                          22.sp,
                          boldText: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showYesSignUPCustomDialog(
  BuildContext context,
  String title,
  String message,
  image,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 100.h,
                width: dynamicWidth(context, 0.3),
                child: Lottie.asset(
                  image,
                  animate: true,
                  repeat: true,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 500.w,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontFamily: "Poppins",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 8.h,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: message,
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontFamily: "Poppins",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ])),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  AppRoutes.push(context, PageTransitionType.bottomToTop,
                      const SignInScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                  width: 150.w,
                  height: 55.h,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text(
                          context,
                          'Done',
                          22.sp,
                          boldText: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showNoSignUPCustomDialog(
  BuildContext context,
  String title,
  String message,
  image,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 100.h,
                width: dynamicWidth(context, 0.3),
                child: Lottie.asset(
                  image,
                  animate: true,
                  repeat: true,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 500.w,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontFamily: "Poppins",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 8.h,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: message,
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontFamily: "Poppins",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ])),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  AppRoutes.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                  width: 150.w,
                  height: 55.h,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text(
                          context,
                          'Done',
                          22.sp,
                          boldText: FontWeight.w600,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}
