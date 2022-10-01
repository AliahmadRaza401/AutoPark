import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/singIn/signIn.dart';
import 'package:parkingapp/firebaseService/firebaceServices.dart';
import 'package:parkingapp/firebaseService/suthenticationService.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/authentication_Provider.dart';
import '../chose Screen/choseScreen.dart';
import '../onBoardingScreen/onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthenticationProvider authenticationProviderProvider;
  @override
  void initState() {
    super.initState();
    authenticationProviderProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 3), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await authenticationProviderProvider.getUserLoggedIn();
    // var id = FirebaseAuth.instance.currentUser!.uid;
    print('id: $id');
    var viewed = prefs.getBool("onBoard");
    print('viewed: $viewed');
    if (id == true) {
      AppRoutes.pushAndRemoveUntil(
          context, PageTransitionType.bottomToTop, ChoseScreen());
    } else {
      if (viewed == true) {
//         SchedulerBinding.instance.addPostFrameCallback((_) {
//         AppRoutes.pushAndRemoveUntil(
//             context, PageTransitionType.bottomToTop, SignInScreen());
// });
        AppRoutes.pushAndRemoveUntil(
            context, PageTransitionType.bottomToTop, SignInScreen());
      } else {
        AppRoutes.pushAndRemoveUntil(
            context, PageTransitionType.bottomToTop, OnBoarding());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 25.w,),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/appicon.png'))),
            ),
          ],
        ),
      ),
    );
  }
}
