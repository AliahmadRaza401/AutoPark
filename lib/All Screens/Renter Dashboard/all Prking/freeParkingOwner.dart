import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
import 'package:parkingapp/custom%20Widgets/parking_ListTile.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

import '../../../custom Widgets/default_Text.dart';

class FreeParkingOwner extends StatefulWidget {
  const FreeParkingOwner({Key? key}) : super(key: key);

  @override
  State<FreeParkingOwner> createState() => _FreeParkingOwnerState();
}

class _FreeParkingOwnerState extends State<FreeParkingOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 25.w, right: 25.w),
        child: Column(
          children: [
            heightBox(context, 0.02),
            customAppBarWithBack(context, "Free Parking"),
            Container(
              // color: Colors.amber,
              height: dynamicHeight(context, 0.85),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('parking')
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where('bookerID', isEqualTo: '')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length <= 0
                        ? Center(
                            child: Text("No Data"),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return parkingTileCommon(context, doc);
                            });
                  } else {
                    return const Text("No data");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
