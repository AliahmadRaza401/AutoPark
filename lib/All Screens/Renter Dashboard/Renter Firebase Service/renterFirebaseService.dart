import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/firebaseService/firebaceServices.dart';
import 'package:parkingapp/providers/loadingProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../renterDashBoard.dart/renterDashBardScreen.dart';

class RenterFirebaseService {
  static postParkingDetailsToFirestore(
      BuildContext context,
      location,
      locationLat,
      locationLong,
      postalcode,
      parkingType,
      garageValue,
      roofValue,
      description,
      imageFile,
      parkingName,
      parkingPrice) async {
    final _auth = FirebaseAuth.instance;
    var uuid = const Uuid();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    try {
      _loadingProvider.setLoading(true);
      var parkingImage = await FirebaseServices.imageUpload(
          imageFile, DateTime.now().toString());
      log('locationLat = $locationLat');
      log('locationLong = $locationLong');
      var uniquParkingId = uuid.v1();
      log('uniquParkingId = $uniquParkingId');
      await firebaseFirestore.collection("parking").doc().set({
        'uid': user!.uid,
        'parkingLocation': location,
        'parkingLocationLatitude': locationLat,
        'parkingLocationLongitude': locationLong,
        'postalCode': postalcode,
        'parkingType': parkingType,
        'garageValue': garageValue,
        'roofValue': roofValue,
        'description': description,
        'parkingImg': parkingImage,
        'bookedStatus': 'free',
        'bookerID': '',
        'bookedTime': '',
        'totalTime': '',
        'startTime': '',
        'endTime': '',
        'totalPrice': '',
        'parkingName': parkingName,
        'parkingPrice': parkingPrice,
        'createdAt': DateTime.now(),
        'parkingUniqueId':uniquParkingId,
      }).then((value) {
        log('In Function lat =$locationLat ');
        log('In Function  long =$locationLong ');
        _loadingProvider.setLoading(false);
        ToastUtils.showCustomToast(context,
            "Success \n Parking Created Successfully!!.", Colors.green);
        AppRoutes.pushAndRemoveUntil(context, PageTransitionType.bottomToTop,
            const RenterDashBoardScreen());
      });
    } catch (error) {
      _loadingProvider.setLoading(false);
      ToastUtils.showCustomToast(context,
          "$error!!! \n Parking  Not Created!!!", AppColor.primaryColor);
    }

    _loadingProvider.setLoading(false);
  }
}
