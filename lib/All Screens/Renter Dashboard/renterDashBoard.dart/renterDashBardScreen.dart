import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/all%20Prking/allParkings.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/all%20Prking/bookedParkingOwner.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/all%20Prking/freeParkingOwner.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/post%20Parking%20Screen/postParkingScreen.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/custom%20Widgets/parking_ListTile.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkingapp/utils/appStyle.dart';
import 'package:parkingapp/utils/dynamic_size.dart';
import 'package:readmore/readmore.dart';

import '../../chose Screen/choseScreen.dart';

class RenterDashBoardScreen extends StatefulWidget {
  const RenterDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<RenterDashBoardScreen> createState() => _RenterDashBoardScreenState();
}

class _RenterDashBoardScreenState extends State<RenterDashBoardScreen> {
  final fireStore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot? querySnapshot;
  QuerySnapshot? querySnapshot2;
  List allParkingList = [];
  List allData = [];
  int allParking = 0;
  int bookedParking = 0;
  int freeParking = 0;
  int completeParking = 0;
  int cancelParking = 0;
  int totalEarning = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    querySnapshot = await fireStore.collection('bookings').get();
    querySnapshot2 = await fireStore.collection('parking').get();
    allParkingList =
        await querySnapshot2!.docs.map((doc) => doc.data()).toList();
    for (var element in allParkingList) {
      log(element['uid']);
      log(uid.toString());
      if (element['uid'].toString() == uid.toString()) {
        allParking = allParking + 1;
        log(allParking.toString());
      }
    }
    // Get data from docs and convert map to List
    allData = await querySnapshot!.docs.map((doc) => doc.data()).toList();

    debugPrint('allData: $allData');
    print(uid);
    print("loop.....");

    for (var i = 0; i < allData.length; i++) {
      if (allData[i]['uid'].toString() == uid.toString()) {
        log('allParking $allParking');
      }
      if (allData[i]['uid'].toString() == uid.toString() &&
          allData[i]['bookedStatus'].toString() == "Ongoing") {
        bookedParking = bookedParking + 1;
      }
      if (allData[i]['uid'].toString() == uid.toString() &&
          allData[i]['bookedStatus'].toString() == "Completed") {
        completeParking = completeParking + 1;
        var totEr = allData[i]['totalPrice'] == null
            ? 0
            : int.parse(allData[i]['totalPrice'].toString());

        totalEarning = totEr + totalEarning;
        log('totalEarning = $totalEarning');
        log('totEr = $totEr');
      }
      if (allData[i]['uid'].toString() == uid.toString() &&
          allData[i]['bookedStatus'].toString() == "Canceled") {
        cancelParking = cancelParking + 1;
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppRoutes.push(
            context, PageTransitionType.bottomToTop, const ChoseScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            AppRoutes.push(context, PageTransitionType.rightToLeft,
                const PostParkingScreen());
          },
          label: text(
            context,
            'Add Parking',
            12.sp,
            color: AppColor.whiteColor,
            boldText: FontWeight.w700,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // AppRoutes.pop(context);

                        AppRoutes.push(context, PageTransitionType.bottomToTop,
                            const ChoseScreen());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.lightGreybg),
                        padding: EdgeInsets.all(7.h),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    text(
                      context,
                      'Dashboard',
                      29.sp,
                      boldText: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.lightGreybg),
                      padding: EdgeInsets.all(7.h),
                      child: const Icon(
                        Icons.notifications,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    text(
                      context,
                      'Balance:',
                      22.sp,
                      color: AppColor.blackColor,
                      boldText: FontWeight.w500,
                    ),
                    text(
                      context,
                      '   \$$totalEarning',
                      22.sp,
                      color: AppColor.primaryColor,
                      boldText: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        AppRoutes.push(
                            context,
                            PageTransitionType.bottomToTop,
                            AllParkingsScreen(
                              totalParking: allParking,
                              bookedParking: bookedParking,
                              cancleParking: cancelParking,
                              completeParking: completeParking,
                            ));
                      },
                      child: containerWidget(
                          Colors.purple, allParking.toString(), 'Total'),
                    ),
                    InkWell(
                      onTap: () {
                        AppRoutes.push(
                            context,
                            PageTransitionType.bottomToTop,
                            AllParkingsScreen(
                              totalParking: allParking,
                              bookedParking: bookedParking,
                              cancleParking: cancelParking,
                              completeParking: completeParking,
                            ));
                      },
                      child: containerWidget(AppColor.greenColor,
                          completeParking.toString(), 'Completed'),
                    ),
                  ],
                ),
                SizedBox(
                  height: dynamicHeight(context, 0.015),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        AppRoutes.push(
                            context,
                            PageTransitionType.bottomToTop,
                            AllParkingsScreen(
                              totalParking: allParking,
                              bookedParking: bookedParking,
                              cancleParking: cancelParking,
                              completeParking: completeParking,
                            ));
                      },
                      child: containerWidget(AppColor.primaryColor,
                          bookedParking.toString(), 'Booked'),
                    ),
                    InkWell(
                      onTap: () {
                        AppRoutes.push(
                            context,
                            PageTransitionType.bottomToTop,
                            AllParkingsScreen(
                              totalParking: allParking,
                              bookedParking: bookedParking,
                              cancleParking: cancelParking,
                              completeParking: completeParking,
                            ));
                      },
                      child: containerWidget(AppColor.darkGreyColor,
                          cancelParking.toString(), 'Cancelled'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: text(
                    context,
                    'Recent Booked',
                    22.sp,
                    boldText: FontWeight.w500,
                    color: AppColor.blackColor,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bookings')
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where('bookedStatus', isEqualTo: 'Ongoing')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.length <= 0
                          ? Center(
                              child: Lottie.asset(
                                  'assets/jsonFiles/noData.json',
                                  animate: true,
                                  repeat: true,
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5),
                            )
                          : Container(
                              // color: Colors.amber,
                              // height: dynamicHeight(context, 0.4),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 1 / .3,
                                    // crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 7.0,
                                  ),
                                  itemCount: snapshot.data!.docs.length == null
                                      ? 0
                                      : snapshot.data!.docs.length,
                                  itemBuilder: (context, i) {
                                    return parkingTileCommon(
                                        context, snapshot.data!.docs[i]);
                                  }),
                            );
                    } else {
                      return Lottie.asset('assets/jsonFiles/noData.json',
                          animate: true,
                          repeat: true,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width);
                      ;
                    }
                  },
                ),
                SizedBox(
                  height: 35.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget containerWidget(
    Color colorValue,
    text1value,
    text2value,
  ) {
    return Container(
      height: 100.h,
      width: dynamicWidth(context, 0.4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: colorValue.withOpacity(0.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text(
            context,
            text1value,
            27.sp,
            boldText: FontWeight.w600,
            color: colorValue.withOpacity(0.9),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(
                  context,
                  text2value,
                  16.sp,
                  boldText: FontWeight.w600,
                  color: AppColor.blackColor,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
