import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/customerBottomBar/customerBottomBar.dart';
import 'package:parkingapp/models/singleParkingData.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/providers/loadingProvider.dart';
import 'package:parkingapp/providers/userProfileProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:provider/provider.dart';

import '../../models/profileModel.dart';
import 'home Screen/homeScreen.dart';

class ClientFirebaseService {
  static getAppParkingLocations(
    BuildContext context,
  ) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    List<SingleParkingDataModel> allParkingGlobalList = [];
    Map<String, dynamic> data;

    try {
      Provider.of<GetAllParkingProvider>(context, listen: false)
          .setLoading(true);

      allParkingGlobalList.clear();

      FirebaseFirestore.instance
          .collection('parking')
          .snapshots()
          .listen((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = {"docId": doc.id, ...doc.data()};
          print("thre new data with id   " + data.toString());
          SingleParkingDataModel fData = SingleParkingDataModel.fromJson(data);
          allParkingGlobalList.add(fData);
        }
        Provider.of<GetAllParkingProvider>(context, listen: false)
            .saveDataintoList(allParkingGlobalList);
      });
      Provider.of<GetAllParkingProvider>(context, listen: false)
          .setLoading(false);
    } catch (e) {
      log('Erroe on get All parking = $e');
    }
  }

  static bookParking(
    BuildContext context,
    // parkingId,
    // totalPrice,
    // totalTime,
    // startTime,
    // endTime,
  ) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    GetAllParkingProvider allParkingProvider =
        Provider.of<GetAllParkingProvider>(context, listen: false);
    try {
      // allParkingProvider.singleParkingInstance!.docId,
      //                         allParkingProvider.totalPriceofParking,
      //                         allParkingProvider.subTotal,
      //                         allParkingProvider.startParkingDateTime,
      //                         allParkingProvider.endParkingDateTime,

      _loadingProvider.setLoading(true);
      await firebaseFirestore.collection("bookings").doc().set({
        'uid': user!.uid,
        'parkingLocation':
            allParkingProvider.singleParkingInstance!.parkingLocation,
        'parkingLocationLatitude':
            allParkingProvider.singleParkingInstance!.parkingLocationLatitude,
        'parkingLocationLongitude':
            allParkingProvider.singleParkingInstance!.parkingLocationLongitude,
        'postalCode': allParkingProvider.singleParkingInstance!.postalCode,
        'parkingType': allParkingProvider.singleParkingInstance!.parkingType,
        'garageValue': allParkingProvider.singleParkingInstance!.gragevalue,
        'roofValue': allParkingProvider.singleParkingInstance!.roofValue,
        'description': allParkingProvider.singleParkingInstance!.description,
        'parkingImg': allParkingProvider.singleParkingInstance!.parkingimage,
        'bookedStatus': 'Ongoing',
        'bookerID': user.uid,
        'bookedTime': DateTime.now(),
        'totalTime': allParkingProvider.totalPrkingTime,
        'startTime': allParkingProvider.startParkingDateTime,
        'endTime': allParkingProvider.endParkingDateTime,
        'totalPrice': allParkingProvider.totalPriceofParking,
        'parkingName': allParkingProvider.singleParkingInstance!.parkingName,
        'parkingPrice': allParkingProvider.singleParkingInstance!.parkingPrice,
        'bookmark': false,
        'createdAt': DateTime.now(),
        'parkingUniqueId':allParkingProvider.singleParkingInstance!.uniqueParkingId,
      }).then((value) async {
        // log('totalTime =$totalTime ');
        // log('startTime =$startTime ');

        // Update BookerId
        await firebaseFirestore
            .collection("parking")
            .doc(
              allParkingProvider.singleParkingInstance!.docId,
            )
            .update({
          'bookerID': user.uid,
          'bookedStatus': 'booked',
          'bookedTime': DateTime.now(),
          'totalTime': allParkingProvider.totalPrkingTime,
          'startTime': allParkingProvider.startParkingDateTime,
          'endTime': allParkingProvider.endParkingDateTime,
          'totalPrice': allParkingProvider.subTotal,
        });

        _loadingProvider.setLoading(false);
        ToastUtils.showCustomToast(context,
            "Success \n Parking Updated Successfully!!.", Colors.green);
        AppRoutes.pushAndRemoveUntil(
            context, PageTransitionType.bottomToTop, MyNavigationBar());
      });
    } catch (e) {
      _loadingProvider.setLoading(false);
      ToastUtils.showCustomToast(
          context, "$e!!! \n Parking  Not Updated!!!", AppColor.primaryColor);
    }
  }

  static AddBookmarkParking(BuildContext context, docID) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    try {
      _loadingProvider.setLoading(true);
      await firebaseFirestore.collection("bookings").doc(docID).update({
        "bookmark": true,
      }).then((value) async {
        _loadingProvider.setLoading(false);
        ToastUtils.showCustomToast(
            context, "Success \n Parking Add Successfully!!.", Colors.green);
      });
    } catch (e) {
      _loadingProvider.setLoading(false);
      ToastUtils.showCustomToast(
          context, "$e!!! \n Parking  Not Adeed!!!", AppColor.primaryColor);
    }
  }

  static CancleBookmarkParking(BuildContext context, docID) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    try {
      _loadingProvider.setLoading(true);
      await firebaseFirestore.collection("bookings").doc(docID).update({
        'bookerID': '',
        "bookmark": false,
      }).then((value) async {
        await firebaseFirestore.collection("parking").doc(docID).update({
          'bookerID': '',
          "bookedStatus": 'free',
        });
        _loadingProvider.setLoading(false);
        ToastUtils.showCustomToast(
            context, "Success \n Parking cancel Successfully!!.", Colors.green);
      });
    } catch (e) {
      _loadingProvider.setLoading(false);
      ToastUtils.showCustomToast(
          context, "$e!!! \n Parking  Not Adeed!!!", AppColor.primaryColor);
    }
  }

  static reomveBookmarkParking(BuildContext context, docID) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    try {
      _loadingProvider.setLoading(true);
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection("parking")
          .doc(docID)
          .update({
        "bookmark": false,
      }).then((value) {
        ToastUtils.showCustomToast(
            context, "Parking Remove Success!!!", AppColor.primaryColor);
      });
    } catch (e) {
      _loadingProvider.setLoading(false);
      ToastUtils.showCustomToast(
          context, "$e!!! \n Parking  Not Adeed!!!", AppColor.primaryColor);
    }
  }

  static getUserProfile(
    BuildContext context,
  ) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    Map<String, dynamic> data;
    try {
      userProfileProvider.setLoading(true);
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        data = value.data()!;
        log('profile of user with data  = $data');
        ProfileModel fData = ProfileModel.fromJson(data);
        userProfileProvider.saveProfleValue(fData);
        userProfileProvider.setLoading(false);
      });
    } catch (e) {
      userProfileProvider.setLoading(false);
      log('Error of profile  = $e');
    }
  }
}
