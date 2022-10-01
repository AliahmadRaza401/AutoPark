import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/clientFirebaseService.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/search%20parking%20Screen/searchParkingScreen.dart';
import 'package:parkingapp/All%20Screens/chose%20Screen/choseScreen.dart';
import 'package:parkingapp/custom%20Widgets/alert_dialogs/custom_Alertdialog.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/models/singleParkingData.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/appStyle.dart';
import 'package:provider/provider.dart';
import '../../../custom Widgets/default_Text.dart';
import '../parking Details Screen/parkingDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late GetAllParkingProvider _allParkingProvider;

  @override
  void initState() {
    // _allParkingProvider =
    // Provider.of<GetAllParkingProvider>(context,listen: false);
    // locatePosition();
    ClientFirebaseService.getAppParkingLocations(context);
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    GetAllParkingProvider _allParkingProvider =
        Provider.of<GetAllParkingProvider>(context);
    if (_allParkingProvider.singleParkingloading &&
        _allParkingProvider.allMarkerAdded) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        addingModalBottomSheet(_allParkingProvider.singleParkingInstance!);
        _allParkingProvider.allMarkerAdded = false;
      });
    } else {
      const SizedBox();
    }
    return WillPopScope(
      onWillPop: () async {
        AppRoutes.push(
            context, PageTransitionType.bottomToTop, const ChoseScreen());
        return false;
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _allParkingProvider.singleelementParkingloading(false);
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    mapType: _allParkingProvider.mapTypeValue
                        ? MapType.hybrid
                        : MapType.terrain,
                    rotateGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    trafficEnabled: false,
                    tiltGesturesEnabled: false,
                    scrollGesturesEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    markers: _allParkingProvider.markers,
                    initialCameraPosition: CameraPosition(
                      target: _allParkingProvider.initialLatLng,
                      zoom: 14.47,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _allParkingProvider.myController = controller;
                      _controller.complete(controller);

                      _allParkingProvider.locatePosition();
                    },
                  ),
                ),
              ),
              Positioned(
                top: 30.h,
                width: 351.w,
                height: 62.h,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.bottomToTop,
                              const ChoseScreen());
                        },
                        child: Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEFECEC),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const SearchParkingScreen());
                        },
                        child: Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEFECEC),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.2,
                      ),
                      InkWell(
                        onTap: () {
                          // AppRoutes.pop(context);
                          // cDialog(context);
                        },
                        child: Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEFECEC),
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 145.h,
                right: 10.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _allParkingProvider.mapTypeValue =
                            !_allParkingProvider.mapTypeValue;
                        _allParkingProvider
                            .setMapTypeFun(_allParkingProvider.mapTypeValue);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: 5,
                            bottom: 5,
                          ),
                          height: 45.h,
                          width: 45.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primaryColor,
                          ),
                          child: const Icon(
                            Icons.map,
                            color: AppColor.whiteColor,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _allParkingProvider.myController!.animateCamera(
                          CameraUpdate.zoomIn(),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            margin: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              top: 5,
                              bottom: 5,
                            ),
                            height: 45.h,
                            width: 45.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primaryColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColor.whiteColor,
                              size: 35,
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _allParkingProvider.myController!.animateCamera(
                          CameraUpdate.zoomOut(),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: 5,
                            bottom: 5,
                          ),
                          height: 45.h,
                          width: 45.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primaryColor,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: AppColor.whiteColor,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addingModalBottomSheet(SingleParkingDataModel singleparkingdata) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: AppColor.darkGreyColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer(),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Details",
                      style: AppStyle.heading,
                    )
                    // text(
                    //   context,
                    //   'Details',
                    //   24.sp,
                    //   color: AppColor.blackColor,
                    //   boldText: FontWeight.w600,
                    // ),
                    ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: text(
                    context,
                    singleparkingdata.bookerId == null ||
                            singleparkingdata.bookerId!.isEmpty
                        ? 'Free'
                        : 'Booked',
                    24.sp,
                    color: singleparkingdata.bookerId! == 'free'
                        ? AppColor.greenColor
                        : AppColor.primaryColor,
                    boldText: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              thickness: 3.h,
              color: AppColor.darkGreyColor,
            ),
            SizedBox(height: 10.h),
            Container(
              // width: 360.w,
              // height: 175.h,

              child: FadeInImage.assetNetwork(
                placeholder: AppImages.parkingPic,
                image: singleparkingdata.parkingimage!,
                fit: BoxFit.cover,
                width: 360.w,
                height: 175.h,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(
                  context,
                  singleparkingdata.parkingName!,
                  20.sp,
                  color: AppColor.blackColor,
                  boldText: FontWeight.w600,
                ),
                text(
                  context,
                  singleparkingdata.bookerId == null ||
                          singleparkingdata.bookerId!.isEmpty
                      ? 'Free'
                      : 'Booked',
                  16.sp,
                  color: AppColor.primaryColor,
                  boldText: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(
                  context,
                  singleparkingdata.parkingLocation!.length > 10
                      ? singleparkingdata.parkingLocation!.substring(0, 20)
                      : singleparkingdata.parkingLocation!,
                  15.sp,
                  color: AppColor.greyColor,
                  boldText: FontWeight.w500,
                ),
                text(
                  context,
                  'Parking Type',
                  12.sp,
                  color: AppColor.blackColor,
                  boldText: FontWeight.w400,
                ),
              ],
            ),
            singleparkingdata.bookerId == null ||
                    singleparkingdata.bookerId!.isEmpty
                ? Divider(
                    thickness: 3.h,
                    color: AppColor.greyColor,
                  )
                : SizedBox(),
            SizedBox(height: 15.h),
            singleparkingdata.bookerId == null ||
                    singleparkingdata.bookerId!.isEmpty
                ? Row(
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
                          AppRoutes.push(
                              context,
                              PageTransitionType.bottomToTop,
                              const ParkingDetailsScreen());
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
                                  'Details',
                                  15.sp,
                                  boldText: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColor.whiteColor,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
