import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/renterDashBoard.dart/renterDashBardScreen.dart';
import 'package:parkingapp/All%20Screens/chose%20Screen/auth_Class.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

import '../Client DashBoard/customerBottomBar/customerBottomBar.dart';
import '../Client DashBoard/home Screen/homeScreen.dart';

class ChoseScreen extends StatefulWidget {
  const ChoseScreen({Key? key}) : super(key: key);

  @override
  State<ChoseScreen> createState() => _ChoseScreenState();
}

class _ChoseScreenState extends State<ChoseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.homebgd,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     onPressed: () async {
            //       FireAuth.signInWithGoogle(context: context);
            //       // var res = await FireAuth.registerUsingEmailPassword(
            //       //     context: context,
            //       //     name: "name",
            //       //     email: "e111@gmail.com",
            //       //     password: "password");

            //       // print("res_________________________________ $res");
            //     },
            //     child: Text("data")),
            GestureDetector(
              onTap: () {
                AppRoutes.push(context, PageTransitionType.topToBottom,
                    const RenterDashBoardScreen());
              },
              child: choesScreenWidget(
                'Owner',
                AppImages.rentParking,
              ),
            ),
            GestureDetector(
              onTap: () {
                AppRoutes.push(context, PageTransitionType.topToBottom,
                    const MyNavigationBar());
              },
              child: choesScreenIconWidget(
                'Renter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget choesScreenWidget(
    widgetText,
    widgetImg,
  ) {
    return Container(
      margin: EdgeInsets.all(5.h),
      padding: EdgeInsets.all(15.h),
      height: 207.h,
      width: 470.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColor.primaryColor.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: widgetText,
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80.h,
                child: Image(
                  image: AssetImage(widgetImg),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget choesScreenIconWidget(
    widgetText,
  ) {
    return Container(
      margin: EdgeInsets.all(5.h),
      padding: EdgeInsets.all(15.h),
      height: 207.h,
      width: 470.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColor.primaryColor.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // width: dynamicWidth(context, 0.8),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: widgetText,
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: Colors.white,
                size: 80,
              ),
            ],
          ),

          // Container(
          //   width: dynamicWidth(context, 0.8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       RichText(
          //         text: TextSpan(
          //             text: widgetText,
          //             style: TextStyle(
          //                 color: AppColor.whiteColor,
          //                 fontSize: 36.sp,
          //                 fontWeight: FontWeight.w600)),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
