import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/clientFirebaseService.dart';
import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/custom%20Widgets/parking_ListTile.dart';
import 'package:parkingapp/models/singleParkingData.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:parkingapp/utils/dynamic_size.dart';
import 'package:provider/provider.dart';

import 'my Parking DetailsScreen/myParkingDetailsScreen.dart';

class UserBookings extends StatefulWidget {
  UserBookings({Key? key}) : super(key: key);

  @override
  State<UserBookings> createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  final fireStore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot? querySnapshot;
  List allData = [];
  List allParking = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<SingleParkingDataModel> allParkingGlobalList = [];
  late Map<String, dynamic> data;

  Future<void> getData() async {
    // allParkingGlobalList.clear();

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('parking')
    //     .snapshots()
    //     .listen((querySnapshot) {
    //   for (var doc in querySnapshot.docs) {
    //     Map<String, dynamic> data = {"docId": doc.id, ...doc.data()};
    //     print("thre new data with id   " + data.toString());
    //     SingleParkingDataModel fData = SingleParkingDataModel.fromJson(data);
    //     allParkingGlobalList.add(fData);
    //   }
    //   Provider.of<GetAllParkingProvider>(context, listen: false)
    //       .saveDataintoList(allParkingGlobalList);
    // });
    // Get docs from collection reference
    querySnapshot = await fireStore.collection('bookings').get();

    // Get data from docs and convert map to List
    allData = querySnapshot!.docs.map((doc) => doc.data()).toList();
    debugPrint('allData: $allData');
    // for a specific field
    allParking = allData.map((doc) {
      if (doc!['bookerID'].toString() == uid) {
        return doc;
      }
    }).toList();
    debugPrint('allParking: $allParking');
    setState(() {
      loading = false;
    });
  }

  List chipsList = [
    "Ongoing",
    "Completed",
    "Canceled",
  ];
  int selectedChip = 0;

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < chipsList.length; i++) {
      Widget item = Container(
        // color: Colors.amber,
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 1),
        child: ChoiceChip(
          label: Text(chipsList[i]),
          labelStyle: TextStyle(
              color: selectedChip == i
                  ? AppColor.whiteColor
                  : AppColor.primaryColor,
              fontWeight: FontWeight.w600),
          labelPadding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, 0.05), vertical: 2),
          backgroundColor: Color(0xffEFEFEF),
          selected: selectedChip == i,
          selectedColor:
              selectedChip == i ? AppColor.primaryColor : Colors.white,
          side: BorderSide(
            color: selectedChip != i ? AppColor.primaryColor : Colors.white,
          ),
          onSelected: (bool value) {
            setState(() {
              selectedChip = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    GetAllParkingProvider allParkingProvider =
        Provider.of<GetAllParkingProvider>(context);
    return SafeArea(
      child: Container(
        height: dynamicHeight(context, 1),
        margin: EdgeInsets.symmetric(
            horizontal: 20, vertical: dynamicHeight(context, 0.02)),
        child: Column(
          children: [
            customAppBar(context, "My Parking"),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: techChips(),
            ),
            SizedBox(
              height: 20,
            ),
            loading == true
                ? Container(
                    height: dynamicHeight(context, 0.65),
                    child: Center(
                      child: SpinKitThreeBounce(
                        color: AppColor.primaryColor,
                        size: 30.0,
                      ),
                    ),
                  )
                : Container(
                    height: dynamicHeight(context, 0.65),
                    child: ListView.builder(
                        itemCount: allData.length,
                        itemBuilder: (context, i) {
                          if (
                              // allParkingProvider.allParkingDetails[i].bookedStatus == chipsList[selectedChip]
                              allData[i]['bookedStatus'].toString() ==
                                  chipsList[selectedChip]) {
                            return InkWell(
                              onTap: () {
                                print('Taped');
                                AppRoutes.push(
                                  context,
                                  PageTransitionType.bottomToTop,
                                  MyParkingDetailsScreen(
                                    wholeParkingData: allData[i],
                                    docId: querySnapshot!.docs[i].id
                                                  .toString(),
                                  ),
                                );
                              },
                              child: ParkingListTile(
                                context,
                                allData[i],
                                InkWell(
                                  onTap: () async {
                                    if (allData[i]['bookedStatus'] == true) {
                                      ToastUtils.showCustomToast(
                                          context,
                                          "Success \n Parking already Added!!.",
                                          Colors.green);
                                    } else {
                                      await ClientFirebaseService
                                          .AddBookmarkParking(
                                              context,
                                              querySnapshot!.docs[i].id
                                                  .toString());
                                      getData();
                                      setState(() {});
                                    }
                                  },
                                  child: Icon(
                                    allData[i]['bookedStatus'] == true
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
          ],
        ),
      ),
    );
  }
}
