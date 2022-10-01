import 'package:flutter/material.dart';
import 'package:parkingapp/firebaseService/firebaceServices.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/signUp/signUp.dart';
import 'package:parkingapp/All%20Screens/singIn/signIn.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../All Screens/chose Screen/choseScreen.dart';
import '../custom Widgets/alert_dialogs/custom_Alertdialog.dart';
import '../providers/loadingProvider.dart';
import '../routes/app_Routes.dart';

class AuthenticationProvider with ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  bool loading = false;
  var result;
  var errorMessage;
  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  //SignIn
  signIn(BuildContext context, String email, String password) async {
    final auth = FirebaseAuth.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setLoading(true);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                pref.setString("userId", auth.currentUser!.uid),

                // ToastUtils.showCustomToast(
                //     context, "Success \n Login Successful!!", Colors.green),

                setUserLoggedIn(true),
                // loadingProvider.setLoading(false),
                result = true,
              });
      loadingProvider.setLoading(false);
      if (result == true) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (error) {
      result = false;
      switch (error.code) {
        case "invalid-email":
          ToastUtils.showCustomToast(
              context, "Error \n Your email address is invalid", Colors.red);
          break;
        case "wrong-password":
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "Your password is wrong.".tr);
          ToastUtils.showCustomToast(
              context, "Error \n Your password is wrong", Colors.red);

          break;
        case "user-not-found":
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "User with this email does not exist.".tr);
          ToastUtils.showCustomToast(context,
              "Error \n User with this email does not exist.", Colors.red);

          break;
        case "user-disabled":
          // ToastUtils.showErrorToast(context, "Error".tr,
          //     "User with this email has been disabled.".tr);
          ToastUtils.showCustomToast(context,
              "Error \n User with this email has been disabled.", Colors.red);

          break;
        case "too-many-requests":
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "Too many requests".tr);
          ToastUtils.showCustomToast(
              context, "Error \n Too many requests.", Colors.red);
          break;
        case "operation-not-allowed":
          // ToastUtils.showErrorToast(context, "Error".tr,
          //     "Signing in with Email and Password is not enabled.".tr);
          ToastUtils.showCustomToast(
              context,
              "Error \n Signing in with Email and Password is not enabled.",
              Colors.red);

          break;
        default:
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "An undefined Error happened".tr);
          ToastUtils.showCustomToast(
              context, "Error \n An undefined Error happened.", Colors.red);
      }
      loadingProvider.setLoading(false);

      // return "false";
      return false;
    }
  }

  // SignUp-----------------------------------------
  signUp(BuildContext context, String email, String password, fullName,
      mobilenumber, imageFile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final _auth = FirebaseAuth.instance;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    _loadingProvider.setLoading(true);
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                pref.setString("userId", _auth.currentUser!.uid),
                postDetailsToFirestore(context, fullName, email, mobilenumber,
                    password, imageFile),
                result = true,
              });
      _loadingProvider.setLoading(false);
      if (result == true) {
        return true;
      } else {
        return false;
      }

      //     .catchError((e) {
      //   print('e: $e');
      //   _loadingProvider.setLoading(false);
      // });
    } on FirebaseAuthException catch (error) {
      _loadingProvider.setLoading(false);
      result = false;
      print('error: $error');
      print('error.code): ${error.code})');
      switch (error.code) {
        case "invalid-email":
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "Your email address is invalid".tr);
          ToastUtils.showCustomToast(
              context, "Error \n Your email address is invalid.", Colors.red);
          break;
        case "wrong-password":
          errorMessage = "wrong-password";
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "Your password is wrong.".tr);
          // ToastUtils.showCustomToast(
          //     context, "Error \n Your password is wrong.", Colors.red);
          break;
        case "user-not-found":
          errorMessage = "user-not-found";
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "User with this email does not exist.".tr);
          // ToastUtils.showCustomToast(context,
          //     "Error \n User with this email does not exist.", Colors.red);
          break;
        case "user-disabled":
          errorMessage = 'user-disabled';
          // ToastUtils.showErrorToast(context, "Error".tr,
          //     "User with this email has been disabled.".tr);
          // ToastUtils.showCustomToast(context,
          //     "Error \n User with this email has been disabled.", Colors.red);

          break;
        case "too-many-requests":
          errorMessage = 'too-many-requests';
          // ToastUtils.showErrorToast(context, "Error", "Too many requests".tr);
          // ToastUtils.showCustomToast(
          //     context, "Error \n Too many requests.", Colors.red);

          break;
        case "operation-not-allowed":
          errorMessage = 'operation-not-allowed';
          // ToastUtils.showErrorToast(context, "Error".tr,
          //     "Signing in with Email and Password is not enabled.".tr);
          // ToastUtils.showCustomToast(
          //     context,
          //     "Error \n Signing in with Email and Password is not enabled.",
          //     Colors.red);

          break;
        case "email-already-in-use":
          errorMessage = 'email-already-in-use';

          // ToastUtils.showErrorToast(context, "Error".tr,
          //     "Email already exist, kindly try some one else".tr);
          // ToastUtils.showCustomToast(
          //     context,
          //     "Error \n Email already exist, kindly try some one else.",
          //     Colors.red);

          break;
        default:
          // SizedBox();
          errorMessage = 'Something Went Wrong';
          // ToastUtils.showErrorToast(
          //     context, "Error".tr, "An undefined Error happened".tr);
          ToastUtils.showCustomToast(
              context, "Error \n An undefined Error happened.", Colors.red);
      }
      _loadingProvider.setLoading(false);
      return false;
    }
  }

  postDetailsToFirestore(BuildContext context, fullName, email, mobileNumber,
      password, imageFile) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    LoadingProvider _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    var image = await FirebaseServices.imageUpload(imageFile, email);
    // UserProvider _userProvider =
    //     Provider.of<UserProvider>(context, listen: false);

    await firebaseFirestore.collection("users").doc(user!.uid).set({
      'uid': user.uid,
      'email': email,
      'fullName': fullName,
      'password': password,
      'mobileNumber': '0$mobileNumber',
      'image': image,
    }).then((value) {
      // _userProvider.uid = user.uid.toString();
      // _userProvider.email = email.toString();
      // _userProvider.password = password.toString();
      // _userProvider.fullName = fullName.toString();
      // _userProvider.phoneNumber = '0$mobileNumber';
      // _userProvider.image = image.toString();

      // AppRoutes.push(context, HomePage());

      // ToastUtils.showSuccessToast(
      //     context, "Success".tr, "Account Created Successfully!!");
      _loadingProvider.setLoading(false);
      // ToastUtils.showCustomToast(
      //     context, "Success \n Account Created Successfully!!.", Colors.green);
    }).catchError((e) {});
    _loadingProvider.setLoading(false);

    // AppRoutes.push(
    //     context,
    //     const LoginPage(
    //       name: "Trader",
    //     ));

    // MyMotionToast.success(
    //   context,
    //   "Success",
    //   'Account created successfully :) ',
    // );
  }

  // LogOut--------------------------------------

  logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    setUserLoggedIn(false);
    // AppRoutes.replace(context, Intro());
    AppRoutes.pushAndRemoveUntil(
        context, PageTransitionType.bottomToTop, SignInScreen());
  }

  // user Logged
  setUserLoggedIn(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userLoggedIn', value);
  }

// get user LoggedIn value
  getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('userLoggedIn');
    return boolValue;
  }

  // Farmer Logged
  farmerLoggedIn(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('farmerLoggedIn', value);
  }

// get Farmer LoggedIn value
  getFarmerLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('farmerLoggedIn');
    return boolValue;
  }

// save FarmerId
  saveFarmerID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('farmerID', value);
  }

  // get Farmer LoggedIn value
  getFarmerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('farmerID');
    return value;
  }

  saveUniqueFarmerID(String farmerValue) async {
    SharedPreferences prefsValue = await SharedPreferences.getInstance();
    prefsValue.setString('uniqueFarmerID', farmerValue.toString());
  }

  getUniqueFarmerID() async {
    SharedPreferences prefsValue = await SharedPreferences.getInstance();
    String? farmerValue = prefsValue.getString('uniqueFarmerID');
    return farmerValue;
  }

  clearSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // save TraderId
  saveTraderID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('traderID', value);
  }

  // get Farmer LoggedIn value
  getTraderID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('traderID');
    return value;
  }
}
