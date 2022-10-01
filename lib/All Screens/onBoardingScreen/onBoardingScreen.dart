import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../signUp/signUp.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final introKey = GlobalKey<IntroductionScreenState>();

  _storeOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoard', true);
  }

  void _onIntroEnd(context) {
    _storeOnboardInfo();
    AppRoutes.pushAndRemoveUntil(
      context,
      PageTransitionType.topToBottom,
      const SignUpScreen(),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        fontSize: 19.0,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w300,
        color: AppColor.primaryColor);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w700,
          color: AppColor.primaryColor),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,

      pages: [
        PageViewModel(
          title: "Find Parking Places Around You Easily",
          body:
              "You can find best parking around easily, we offer best nearby parking to you as you want",
          image: _buildImage(AppImages.onboarding1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book and Pay Parking Quickly & Safely",
          body:
              "We offer pakring with full safety, Now you can book parking with 100% satisfaction, So, Quick pay and Book now",
          image: _buildImage(AppImages.onboarding2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Extend Parking Time As You Need",
          body:
              "Now you can increase time limit of parking any time as before book or after book also as you need",
          image: _buildImage(AppImages.onboarding3),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(
            color: AppColor.primaryColor,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: AppColor.primaryColor,
      ),
      done: const Text('Done',
          style: TextStyle(
              color: AppColor.primaryColor,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,

      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: AppColor.primaryColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
