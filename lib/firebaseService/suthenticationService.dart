// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:parkingapp/All%20Screens/signUp/signUp.dart';
// import 'package:parkingapp/All%20Screens/singIn/signIn.dart';
// import 'package:parkingapp/utils/customToast.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../All Screens/chose Screen/choseScreen.dart';
// import '../custom Widgets/alert_dialogs/custom_Alertdialog.dart';
// import '../providers/loadingProvider.dart';
// import '../routes/app_Routes.dart';
// import 'firebaceServices.dart';

// class FirebaseAuthServices {
//   //SignIn
//   static signIn(BuildContext context, String email, String password) async {
//     final auth = FirebaseAuth.instance;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     LoadingProvider loadingProvider =
//         Provider.of<LoadingProvider>(context, listen: false);
//     loadingProvider.setLoading(true);
//     try {
//       await auth
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((uid) => {
//                 pref.setString("userId", auth.currentUser!.uid),

//                 showCustomDialog(
//                   context,
//                   'Congratulations!',
//                   'Login Successfully',
//                   () {
//                     AppRoutes.pushAndRemoveUntil(context,
//                         PageTransitionType.bottomToTop, const ChoseScreen());
//                   },
//                   'assets/jsonFiles/successful.json',
//                 ),
//                 // ToastUtils.showCustomToast(
//                 //     context, "Success \n Login Successful!!", Colors.green),

//                 setUserLoggedIn(true),
//                 loadingProvider.setLoading(false),
//                 return true,
//               });
//     } on FirebaseAuthException catch (error) {
//       switch (error.code) {
//         case "invalid-email":
//           ToastUtils.showCustomToast(
//               context, "Error \n Your email address is invalid", Colors.red);
//           break;
//         case "wrong-password":
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "Your password is wrong.".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n Your password is wrong", Colors.red);

//           break;
//         case "user-not-found":
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "User with this email does not exist.".tr);
//           ToastUtils.showCustomToast(context,
//               "Error \n User with this email does not exist.", Colors.red);

//           break;
//         case "user-disabled":
//           // ToastUtils.showErrorToast(context, "Error".tr,
//           //     "User with this email has been disabled.".tr);
//           ToastUtils.showCustomToast(context,
//               "Error \n User with this email has been disabled.", Colors.red);

//           break;
//         case "too-many-requests":
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "Too many requests".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n Too many requests.", Colors.red);
//           break;
//         case "operation-not-allowed":
//           // ToastUtils.showErrorToast(context, "Error".tr,
//           //     "Signing in with Email and Password is not enabled.".tr);
//           ToastUtils.showCustomToast(
//               context,
//               "Error \n Signing in with Email and Password is not enabled.",
//               Colors.red);

//           break;
//         default:
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "An undefined Error happened".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n An undefined Error happened.", Colors.red);
//       }
//       loadingProvider.setLoading(false);

//       return "false";
//     }
//   }

//   // SignUp-----------------------------------------
//   static void signUp(BuildContext context, String email, String password,
//       fullName, mobilenumber, imageFile) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     final _auth = FirebaseAuth.instance;
//     LoadingProvider _loadingProvider =
//         Provider.of<LoadingProvider>(context, listen: false);
//     _loadingProvider.setLoading(true);
//     try {
//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) => {
//                 pref.setString("userId", _auth.currentUser!.uid),
//                 postDetailsToFirestore(context, fullName, email, mobilenumber,
//                     password, imageFile),
//               });
//       //     .catchError((e) {
//       //   print('e: $e');
//       //   _loadingProvider.setLoading(false);
//       // });
//     } on FirebaseAuthException catch (error) {
//       print('error: $error');
//       print('error.code): ${error.code})');
//       switch (error.code) {
//         case "invalid-email":
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "Your email address is invalid".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n Your email address is invalid.", Colors.red);
//           break;
//         case "wrong-password":
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "Your password is wrong.".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n Your password is wrong.", Colors.red);
//           break;
//         case "user-not-found":
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "User with this email does not exist.".tr);
//           ToastUtils.showCustomToast(context,
//               "Error \n User with this email does not exist.", Colors.red);
//           break;
//         case "user-disabled":
//           // ToastUtils.showErrorToast(context, "Error".tr,
//           //     "User with this email has been disabled.".tr);
//           ToastUtils.showCustomToast(context,
//               "Error \n User with this email has been disabled.", Colors.red);

//           break;
//         case "too-many-requests":
//           // ToastUtils.showErrorToast(context, "Error", "Too many requests".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n Too many requests.", Colors.red);

//           break;
//         case "operation-not-allowed":
//           // ToastUtils.showErrorToast(context, "Error".tr,
//           //     "Signing in with Email and Password is not enabled.".tr);
//           ToastUtils.showCustomToast(
//               context,
//               "Error \n Signing in with Email and Password is not enabled.",
//               Colors.red);

//           break;
//         case "email-already-in-use":
//           // ToastUtils.showErrorToast(context, "Error".tr,
//           //     "Email already exist, kindly try some one else".tr);
//           ToastUtils.showCustomToast(
//               context,
//               "Error \n Email already exist, kindly try some one else.",
//               Colors.red);

//           break;
//         default:
//           // ToastUtils.showErrorToast(
//           //     context, "Error".tr, "An undefined Error happened".tr);
//           ToastUtils.showCustomToast(
//               context, "Error \n An undefined Error happened.", Colors.red);
//       }
//       _loadingProvider.setLoading(false);
//     }
//   }

//   static postDetailsToFirestore(BuildContext context, fullName, email,
//       mobileNumber, password, imageFile) async {
//     final _auth = FirebaseAuth.instance;
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;
//     LoadingProvider _loadingProvider =
//         Provider.of<LoadingProvider>(context, listen: false);

//     var image = await FirebaseServices.imageUpload(imageFile, email);
//     // UserProvider _userProvider =
//     //     Provider.of<UserProvider>(context, listen: false);

//     await firebaseFirestore.collection("users").doc(user!.uid).set({
//       'uid': user.uid,
//       'email': email,
//       'fullName': fullName,
//       'password': password,
//       'mobileNumber': '0$mobileNumber',
//       'image': image,
//     }).then((value) {
//       // _userProvider.uid = user.uid.toString();
//       // _userProvider.email = email.toString();
//       // _userProvider.password = password.toString();
//       // _userProvider.fullName = fullName.toString();
//       // _userProvider.phoneNumber = '0$mobileNumber';
//       // _userProvider.image = image.toString();

//       // AppRoutes.push(context, HomePage());
     
//       // ToastUtils.showSuccessToast(
//       //     context, "Success".tr, "Account Created Successfully!!");
//       _loadingProvider.setLoading(false);
//       // ToastUtils.showCustomToast(
//       //     context, "Success \n Account Created Successfully!!.", Colors.green);
//       showCustomDialog(
//         context,
//         'Congratulations!',
//         'Account Created Successfully',
//         () {
//            AppRoutes.push(
//           context, PageTransitionType.bottomToTop, const ChoseScreen());
//         },
//         'assets/jsonFiles/successful.json',
//       );
//     }).catchError((e) {});
//     _loadingProvider.setLoading(false);

//     // AppRoutes.push(
//     //     context,
//     //     const LoginPage(
//     //       name: "Trader",
//     //     ));

//     // MyMotionToast.success(
//     //   context,
//     //   "Success",
//     //   'Account created successfully :) ',
//     // );
//   }

//   // LogOut--------------------------------------

//   static logOut(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     setUserLoggedIn(false);
//     // AppRoutes.replace(context, Intro());
//     AppRoutes.pushAndRemoveUntil(
//         context, PageTransitionType.bottomToTop, SignInScreen());
//   }

//   // user Logged
//   static setUserLoggedIn(value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('userLoggedIn', value);
//   }

// // get user LoggedIn value
//   static getUserLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? boolValue = prefs.getBool('userLoggedIn');
//     return boolValue;
//   }

//   // Farmer Logged
//   static farmerLoggedIn(value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('farmerLoggedIn', value);
//   }

// // get Farmer LoggedIn value
//   static getFarmerLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? boolValue = prefs.getBool('farmerLoggedIn');
//     return boolValue;
//   }

// // save FarmerId
//   static saveFarmerID(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//     prefs.setString('farmerID', value);
//   }

//   // get Farmer LoggedIn value
//   static getFarmerID() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? value = prefs.getString('farmerID');
//     return value;
//   }

//   static saveUniqueFarmerID(String farmerValue) async {
//     SharedPreferences prefsValue = await SharedPreferences.getInstance();
//     prefsValue.setString('uniqueFarmerID', farmerValue.toString());
//   }

//   static getUniqueFarmerID() async {
//     SharedPreferences prefsValue = await SharedPreferences.getInstance();
//     String? farmerValue = prefsValue.getString('uniqueFarmerID');
//     return farmerValue;
//   }

//   static clearSharedPref() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }

//   // save TraderId
//   static saveTraderID(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('traderID', value);
//   }

//   // get Farmer LoggedIn value
//   static getTraderID() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? value = prefs.getString('traderID');
//     return value;
//   }
// }
