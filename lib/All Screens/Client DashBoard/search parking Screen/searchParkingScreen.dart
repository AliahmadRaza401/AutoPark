import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/models/singleParkingData.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/AppColor.dart';
import 'package:parkingapp/utils/dynamic_size.dart';
import 'package:provider/provider.dart';

import '../../../custom Widgets/default_Text.dart';
import '../../../providers/allPrkingProvide.dart';

class SearchParkingScreen extends StatefulWidget {
  const SearchParkingScreen({Key? key}) : super(key: key);

  @override
  State<SearchParkingScreen> createState() => _SearchParkingScreenState();
}

class _SearchParkingScreenState extends State<SearchParkingScreen> {
  List<SingleParkingDataModel> filterData = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GetAllParkingProvider allParkingProvider =
        Provider.of<GetAllParkingProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 18.w,
            right: 18.w,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                customAppBarWithBack(context, "Search Parking"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: ((value) {
                          setState(() {
                            filterData = allParkingProvider.allParkingDetails
                                .where((filt) => filt.parkingName
                                    .toString()
                                    .toUpperCase()
                                    .contains(searchController.text
                                        .toString()
                                        .toUpperCase()))
                                .toList();
                            log('filterData =$filterData');
                          });
                        }),
                        decoration: InputDecoration(
                          fillColor: AppColor.greyColor,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                                color: AppColor.primaryColor,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              )),
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.filter_6),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 10.w,
                          ),
                          hintText: 'Search Parking',
                          hintStyle: TextStyle(
                            color: AppColor.blackColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                filterData.isEmpty
                    ? const SizedBox()
                    : Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: text(
                              context,
                              'Results(${filterData.length.toString()})',
                              16.sp,
                              boldText: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 18.h,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      filterData.isEmpty
                          ? const Center(
                              child: Text('Nothing'),
                            )
                          : Container(
                              height: dynamicHeight(context, 0.6),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount:
                                    filterData.isEmpty ? 0 : filterData.length,
                                itemBuilder: (BuildContext context, i) {
                                  SingleParkingDataModel cate = filterData[i];
                                  return searchParking(cate);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchParking(
    SingleParkingDataModel singleParkingDetail,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 40.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.parkingMarkerIcon,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(context, singleParkingDetail.parkingName, 18.sp,
                  boldText: FontWeight.w600, color: AppColor.blackColor),
              text(
                  context,
                  singleParkingDetail.parkingLocation!.length > 25
                      ? singleParkingDetail.parkingLocation!.substring(0, 25)
                      : singleParkingDetail.parkingLocation,
                  14.sp,
                  boldText: FontWeight.w500,
                  color: AppColor.grayTextShade),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(context, singleParkingDetail.parkingType, 18.sp,
                  boldText: FontWeight.w600, color: AppColor.blackColor),
              Row(
                children: [
                  text(context, singleParkingDetail.parkingPrice, 14.sp,
                      boldText: FontWeight.w500, color: AppColor.primaryColor),
                  text(context, '/hour', 14.sp,
                      boldText: FontWeight.w500, color: AppColor.blackColor),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
