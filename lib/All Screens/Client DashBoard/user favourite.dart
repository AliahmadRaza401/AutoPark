import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/clientFirebaseService.dart';
import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/custom%20Widgets/parking_ListTile.dart';
import 'package:parkingapp/models/singleParkingData.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

class UserFavourite extends StatefulWidget {
  UserFavourite({Key? key}) : super(key: key);

  @override
  State<UserFavourite> createState() => _UserFavouriteState();
}

class _UserFavouriteState extends State<UserFavourite> {
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

  Future<void> getData() async {
    // Get docs from collection reference
    querySnapshot = await fireStore.collection('bookings').get();

    // Get data from docs and convert map to List
    allData = querySnapshot!.docs.map((doc) => doc.data()).toList();
    debugPrint('allData: $allData');
    //for a specific field
    // allParking = allData.map((doc) {
    //   if (doc!['uid'].toString() == uid && doc!['bookedStatus'] == "booked") {
    //     return doc;
    //   }
    // }).toList();
    debugPrint('allParking: $allParking');
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: dynamicHeight(context, 1),
        margin: EdgeInsets.symmetric(
            horizontal: 20, vertical: dynamicHeight(context, 0.02)),
        child: Column(
          children: [
            customAppBar(context, "My Bookmark"),
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
                    height: dynamicHeight(context, 0.72),
                    child: ListView.builder(
                        itemCount: allData.length,
                        itemBuilder: (context, i) {
                          if (allData[i]['bookmark'] == true &&
                              allData[i]['bookerID'].toString() ==
                                  uid.toString()) {
                            return GestureDetector(
                              onTap: () async {
                                await ClientFirebaseService
                                    .reomveBookmarkParking(context,
                                        querySnapshot!.docs[i].id.toString());

                                getData();
                              },
                              child: bookmarkListTile(
                                context,
                                allData[i],
                                Icon(
                                  Icons.bookmark,
                                  color: AppColor.primaryColor,
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
