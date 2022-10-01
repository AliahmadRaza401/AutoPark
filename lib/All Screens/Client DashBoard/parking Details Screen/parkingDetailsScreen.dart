import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/parking%20Details%20Screen/bookParkingDetails.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../custom Widgets/default_Text.dart';

class ParkingDetailsScreen extends StatefulWidget {
  const ParkingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ParkingDetailsScreen> createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    GetAllParkingProvider allParkingProvider =
        Provider.of<GetAllParkingProvider>(context);
    var singleParking = allParkingProvider.singleParkingInstance;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              AppRoutes.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            ),
          ),
          title: text(
            context,
            'Parking Details',
            29.sp,
            color: AppColor.blackColor,
            boldText: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.h),
                Container(
                  width: 360.w,
                  height: 175.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    // image: const DecorationImage(
                    //   image: AssetImage(
                    //     AppImages.parkingPic,
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: AppImages.parkingPic,
                    image: singleParking!.parkingimage!,
                    fit: BoxFit.cover,
                    width: 360.w,
                    height: 175.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      // 'Parking Lot of San Manolia',
                      singleParking.parkingName,
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
                      singleParking.parkingLocation,
                      15.sp,
                      color: AppColor.darkGreyColor,
                      boldText: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      text(
                        context,
                        'Parking Type',
                        15.sp,
                        color: AppColor.blackColor,
                        boldText: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      text(
                        context,
                        singleParking.parkingType,
                        16.sp,
                        color: AppColor.greenColor,
                        boldText: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      'Description',
                      25.sp,
                      color: AppColor.blackColor,
                      boldText: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ReadMoreText(
                      singleParking.description!,
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
                        color: AppColor.greyColor),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text(
                            context,
                            '\$${singleParking.parkingPrice}',
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
                        AppRoutes.pop(context);
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
                        AppRoutes.push(context, PageTransitionType.bottomToTop,
                            const BookParkingDetails());
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
                                'Book Parking',
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
}
