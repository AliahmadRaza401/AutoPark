import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/clientFirebaseService.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/home%20Screen/homeScreen.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/my%20Parking%20DetailsScreen/timer.dart';
import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/models/singleParkingData.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/appStyle.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:parkingapp/utils/dynamic_size.dart';
import 'package:readmore/readmore.dart';
import '../../../custom Widgets/default_Text.dart';
// import 'dart:math' as math;

class MyParkingDetailsScreen extends StatefulWidget {
  var wholeParkingData;
  var docId;
  MyParkingDetailsScreen({
    Key? key,
    required this.wholeParkingData,
    required this.docId,
  }) : super(key: key);

  @override
  State<MyParkingDetailsScreen> createState() => _MyParkingDetailsScreenState();
}

class _MyParkingDetailsScreenState extends State<MyParkingDetailsScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  String get timerString {
    Duration duration = controller!.duration! * controller!.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                customAppBarWithBack(context, "Parking Detail"),
                SizedBox(height: 10.h),

                //
                Container(
                  width: 360.w,
                  height: 175.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image:
                          NetworkImage(widget.wholeParkingData['parkingImg']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // SizedBox(height: 20.h),
                // CountDownTimer(
                //   endTime: widget.wholeParkingData['endTime'],
                //   startTime: widget.wholeParkingData['startTime'],
                // ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      // 'Parking Lot of San Manolia',
                      widget.wholeParkingData['parkingName'],
                      20.sp,
                      color: AppColor.blackColor,
                      boldText: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      // '9569, Trantow Courts, San Manolia',
                      widget.wholeParkingData['parkingLocation'],
                      15.sp,
                      color: AppColor.darkGreyColor,
                      boldText: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        context,
                        'Parking Type:',
                        15.sp,
                        color: AppColor.blackColor,
                        boldText: FontWeight.w500,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicWidth(context, 0.05),
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: AppColor.primaryColor,
                              width: 1,
                            )),
                        child: text(
                          context,
                          widget.wholeParkingData['parkingType'],
                          15.sp,
                          boldText: FontWeight.w500,
                          color: AppColor.greenColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: AppStyle.subHeading,
                      )
                      // text(
                      //   context,
                      //   'Description',
                      //   25.sp,
                      //   color: AppColor.blackColor,
                      //   boldText: FontWeight.w700,
                      // ),
                      ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ReadMoreText(
                      widget.wholeParkingData['description'],
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' Show less',
                      moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkGreyColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    height: 93.h,
                    width: 365.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColor.lightGreybg),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text(
                            context,
                            '\$${widget.wholeParkingData['parkingPrice']}',
                            24.sp,
                            boldText: FontWeight.w600,
                            color: AppColor.primaryColor,
                          ),
                          text(
                            context,
                            'per hour',
                            14.sp,
                            boldText: FontWeight.w600,
                            color: AppColor.darkGreyColor,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        log(widget.docId);
                        // AppRoutes.pop(context);
                        log('widget.wholeParkingData[docId] = ${widget.docId}');
                        cancelParking(widget.docId,widget.wholeParkingData['parkingUniqueId']);
                        // ClientFirebaseService.CancleBookmarkParking(
                        //     context, widget.wholeParkingData['docId']);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.greyColor,
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                        width: 150.w,
                        height: 55.h,
                        child: Align(
                          alignment: Alignment.center,
                          child: text(
                            context,
                            'Cancel',
                            15.sp,
                            boldText: FontWeight.w600,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        log(widget.docId);
                        log(widget.wholeParkingData['parkingUniqueId']);
                        completeParking(widget.docId,widget.wholeParkingData['parkingUniqueId']);
                        // AppRoutes.push(context, PageTransitionType.bottomToTop,
                        //     const BookParkingDetails());
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
                                'Complete',
                                15.sp,
                                boldText: FontWeight.w600,
                                color: AppColor.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cancelParking(docId, uniqueParkingId) {
    FirebaseFirestore.instance.collection('bookings').doc(docId).update({
      'bookedStatus': 'Canceled',
      'bookerID': '',
    }).then((value) => {
          FirebaseFirestore.instance
              .collection('parking')
              .doc(docId)
              .update({'bookedStatus': 'free', 'bookerID': 'Canceled'}).then(
                  (value) => {
                        ToastUtils.showCustomToast(
                            context,
                            "Success \n Parking Cancel Successfully!!.",
                            Colors.green),
                        AppRoutes.pop(context),
                      })
        });
  }

  completeParking(docId, uniqueParkingId) {
    log('docId= $docId');
    FirebaseFirestore.instance.collection('bookings').doc(docId).update({
      'bookedStatus': 'Completed',
      'bookerID': '',
    }).then((value) => {
          log('parking status change in bookings'),
          FirebaseFirestore.instance
              .collection('parking').doc()
              // .where('', is    uniqueParkingId)
              .update({
                'bookedStatus': 'free',
                'bookerID': '',
              })
              .then((value) => {
                    log('parking status change in parking'),
                    ToastUtils.showCustomToast(
                        context,
                        "Success \n Parking Completed Successfully!!.",
                        Colors.green),
                    AppRoutes.pushAndRemoveUntil(
                        context, PageTransitionType.bottomToTop, HomeScreen()),
                  })
              .catchError((onError) {
                log('message =$onError');
              })
        });
  }
}
