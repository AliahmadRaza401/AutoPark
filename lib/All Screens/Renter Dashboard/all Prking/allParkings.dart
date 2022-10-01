// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
// import 'package:parkingapp/custom%20Widgets/parking_ListTile.dart';
// import 'package:parkingapp/utils/appColor.dart';
// import 'package:parkingapp/utils/dynamic_size.dart';

// import '../../../custom Widgets/default_Text.dart';

// class AllParkingsScreen extends StatefulWidget {
//   const AllParkingsScreen({Key? key}) : super(key: key);

//   @override
//   State<AllParkingsScreen> createState() => _AllParkingsScreenState();
// }

// class _AllParkingsScreenState extends State<AllParkingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(top: 30.h, left: 25.w, right: 25.w),
//           child: Column(
//             children: [
//               heightBox(context, 0.02),
//               customAppBarWithBack(context, "All Parking"),
//               SizedBox(
//                 height: 500,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('parking')
//                       .where("uid",
//                           isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return snapshot.data!.docs.length <= 0
//                           ? Center(
//                               child: Text("No Data"),
//                             )
//                           : ListView.builder(
//                               itemCount: snapshot.data!.docs.length,
//                               itemBuilder: (context, index) {
//                                 DocumentSnapshot doc =
//                                     snapshot.data!.docs[index];
//                                 return parkingTileCommon(context, doc);
//                               });
//                     } else {
//                       return const Text("No data");
//                     }
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
import 'package:lottie/lottie.dart';
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

import '../../../custom Widgets/custom_nodat_widget.dart';

class AllParkingsScreen extends StatefulWidget {
  int? totalParking, completeParking, bookedParking, cancleParking;

  AllParkingsScreen({
    Key? key,
    required this.totalParking,
    required this.completeParking,
    required this.bookedParking,
    required this.cancleParking,
  }) : super(key: key);

  @override
  State<AllParkingsScreen> createState() => _AllParkingsScreenState();
}

class _AllParkingsScreenState extends State<AllParkingsScreen> {
  final fireStore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot? querySnapshot;
  List allData = [];
  List allParking = [];
  bool loading = true;
  QuerySnapshot? querySnapshot2;
  List allParkingList = [];
  List myParkingList = [];

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
    querySnapshot2 = await fireStore.collection('parking').get();
    allParkingList =
        await querySnapshot2!.docs.map((doc) => doc.data()).toList();
    for (var element in allParkingList) {
      if (element['uid'].toString() == uid.toString()) {
        myParkingList.add(element);
      }
    }
    // Get data from docs and convert map to List
    allData = querySnapshot2!.docs.map((doc) => doc.data()).toList();
    debugPrint('allData: $allData');
    // for a specific field
    allParking = allData.map((doc) {
      if (doc!['uid'].toString() == uid) {
        return doc;
      }
    }).toList();
    debugPrint('allParking: $allParking');
    setState(() {
      loading = false;
    });
  }

  List chipsList = [
    "All",
    "Booked",
    "Completed",
    "Canceled",
  ];

  List statusList = [
    "All",
    "Ongoing",
    "Completed",
    "Canceled",
  ];
  int selectedChip = 0;

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < chipsList.length; i++) {
      Widget item = Container(
        height: 50,
        // color: Colors.amber,
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: dynamicHeight(context, 1),
          margin: EdgeInsets.symmetric(
              horizontal: 20, vertical: dynamicHeight(context, 0.02)),
          child: Column(
            children: [
              customAppBarWithBack(context, "Owner Parking"),
              Wrap(
                children: techChips(),
              ),
              const SizedBox(
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
                  : SizedBox(
                      height: dynamicHeight(context, 0.65),
                      // ignore: prefer_is_empty
                      //  totalParking, completeParking, bookedParking, cancleParking
                      child: widget.cancleParking == 0 && selectedChip == 3 ||
                              widget.totalParking == 0 && selectedChip == 0 ||
                              widget.completeParking == 0 &&
                                  selectedChip == 2 ||
                              widget.bookedParking == 0 && selectedChip == 1
                          ? noDataWidget(context)
                          : ListView.builder(
                              itemCount: allData.length,
                              itemBuilder: (context, i) {
                                if (selectedChip == 1) {
                                  return allData[i]['bookedStatus']
                                              .toString() ==
                                          "Ongoing"
                                      ? parkingTileCommon(context, allData[i])
                                      : SizedBox();
                                } else if (selectedChip == 2) {
                                  return allData[i]['bookedStatus']
                                              .toString() ==
                                          "Completed"
                                      ? parkingTileCommon(context, allData[i])
                                      : SizedBox();
                                } else if (selectedChip == 3) {
                                  return allData[i]['bookedStatus']
                                              .toString() ==
                                          "Canceled"
                                      ? parkingTileCommon(context, allData[i])
                                      : SizedBox();
                                }

                                if (selectedChip == 0) {
                                  return parkingTileCommon(context, allData[i]);
                                } else {
                                  return Lottie.asset(
                                      'assets/jsonFiles/noData.json',
                                      animate: true,
                                      repeat: true,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      width: MediaQuery.of(context).size.width);
                                }
                              })),
            ],
          ),
        ),
      ),
    );
  }
}
