import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/providers/loadingProvider.dart';
import 'package:parkingapp/providers/paymentProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/dynamic_size.dart';
import 'package:provider/provider.dart';

import '../../../custom Widgets/customLoading.dart';
import '../../../custom Widgets/custom_Button.dart';
import '../../../custom Widgets/default_Text.dart';
import '../clientFirebaseService.dart';

class ReviewSummery extends StatefulWidget {
  const ReviewSummery({Key? key}) : super(key: key);

  @override
  State<ReviewSummery> createState() => _ReviewSummeryState();
}

class _ReviewSummeryState extends State<ReviewSummery> {
  var dateFormat = DateFormat.yMMMMd('en_US');
  var timeFormat = DateFormat.jm();
  @override
  Widget build(BuildContext context) {
    GetAllParkingProvider allParkingProvider =
        Provider.of<GetAllParkingProvider>(context);

    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
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
          'Payment',
          29.sp,
          color: AppColor.blackColor,
          boldText: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 20.h,
                  bottom: 20.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.blackColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(23.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    rowTextWidget(
                      'Parking Name',
                      allParkingProvider.singleParkingInstance!.parkingName!,
                    ),
                    rowTextWidget(
                        'Address',
                        allParkingProvider
                            .singleParkingInstance!.parkingLocation!),
                    rowTextWidget(
                      'Vehicle',
                      'Toyota Land Cru (AFD 6397)',
                    ),
                    rowTextWidget(
                      'Parking Type',
                      allParkingProvider.singleParkingInstance!.parkingType!,
                    ),
                    rowTextWidget(
                        'Date',
                        '  ${dateFormat.format(DateTime.parse(allParkingProvider.startParkingDateTime))} ,  ${dateFormat.format(
                          DateTime.parse(
                              allParkingProvider.endParkingDateTime!),
                        )}'),
                    rowTextWidget(
                      'Duration',
                      allParkingProvider.totalPrkingTime.toString(),
                    ),
                    rowTextWidget(
                        'Hours',
                        '${timeFormat.format(DateTime.parse(allParkingProvider.startParkingDateTime))} , ${timeFormat.format(
                          DateTime.parse(allParkingProvider.endParkingDateTime),
                        )}'),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 20.h,
                  bottom: 20.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.blackColor.withOpacity(0.28),
                  borderRadius: BorderRadius.circular(23.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    rowTextWidget('Amount',
                        '\$${allParkingProvider.totalPriceofParking}'),
                    rowTextWidget(
                      'Taxes & Fees (10%)',
                      '\$${allParkingProvider.tenPersentofPayment}',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Divider(
                        thickness: 3,
                        color: AppColor.greyColor.withOpacity(1),
                      ),
                    ),
                    rowTextWidget(
                      'Total',
                      allParkingProvider.subTotal.toString(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              loadingProvider.loading
                  ? customLoadingWidget()
                  : elevatedButton(
                      context,
                      'Continue & Pay',
                      () {
                        log('amount = ${allParkingProvider.subTotal}');
                        paymentProvider.makePayment(
                            // int.parse(allParkingProvider.subTotal.toString()
                            allParkingProvider.subTotal.round(),
                            context);
                      },
                    ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowTextWidget(
    String text1,
    String text2,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(
            context,
            text1,
            16.sp,
            color: AppColor.greyColor.withOpacity(1),
            boldText: FontWeight.w500,
          ),
          Container(
            // color: Colors.amber,
            alignment: Alignment.centerRight,
            width: dynamicWidth(context, 0.5),
            child: text(
              context,
              text2,
              text2.length > 28 ? 9.sp : 16.sp,
              color: AppColor.blackColor,
              boldText: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
