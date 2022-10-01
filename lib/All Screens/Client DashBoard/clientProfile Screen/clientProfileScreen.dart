import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/pdf_view.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/renterDashBoard.dart/renterDashBardScreen.dart';
import 'package:parkingapp/All%20Screens/singIn/signIn.dart';
import 'package:parkingapp/custom%20Widgets/customLoading.dart';
import 'package:parkingapp/custom%20Widgets/custom_appbar.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/providers/userProfileProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/dynamic_size.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/appColor.dart';
import '../clientFirebaseService.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key? key}) : super(key: key);

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  @override
  void initState() {
    super.initState();
    ClientFirebaseService.getUserProfile(context);
  }

  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context);
    return Scaffold(
        body: userProfileProvider.userProfileloading
            ? customLoadingWidget()
            : Container(
                height: dynamicHeight(context, 1),
                margin: EdgeInsets.symmetric(
                    horizontal: 20, vertical: dynamicHeight(context, 0.02)),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Column(
                        children: [
                          customAppBar(context, "Profile"),
                          SizedBox(
                            height: 28.h,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(userProfileProvider
                                .profileModelInstance!.userImage!),
                            radius: 55,
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          text(
                            context,
                            userProfileProvider.profileModelInstance!.name,
                            15.sp,
                            boldText: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          text(
                            context,
                            userProfileProvider.profileModelInstance!.email,
                            15.sp,
                            boldText: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.edit_outlined,
                              color: AppColor.primaryColor,
                            ),
                            title: text(
                              context,
                              "Edit Profile",
                              15.sp,
                              boldText: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            horizontalTitleGap: 1,
                            onTap: () {},
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.wallet,
                              color: AppColor.primaryColor,
                            ),
                            title: text(
                              context,
                              "Paymnet",
                              15.sp,
                              boldText: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            horizontalTitleGap: 1,
                            onTap: () {},
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.notifications,
                              color: AppColor.primaryColor,
                            ),
                            title: text(
                              context,
                              "Notification",
                              15.sp,
                              boldText: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            horizontalTitleGap: 1,
                            onTap: () {},
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.info,
                              color: AppColor.primaryColor,
                            ),
                            title: text(
                              context,
                              "Terms & Conditions",
                              15.sp,
                              boldText: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            horizontalTitleGap: 1,
                            onTap: () async {
                              AppRoutes.push(context, PageTransitionType.fade,
                                  FullPdfViewerScreen());
                              // final path = await OpenDocument.getPathDocument(folderName: "assets/doc");
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (ctx) {
                              //   return FileReaderPage(
                              //     filePath: 'assets/images/privacypolicy.docx',
                              //   );
                              // }));
                            },
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_parking_outlined,
                                      color: AppColor.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    text(
                                      context,
                                      "Owner Mode",
                                      15.sp,
                                      boldText: FontWeight.w600,
                                      color: AppColor.blackColor,
                                    ),
                                  ],
                                ),
                                switchButton(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: dynamicHeight(context, 0.04),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('userLoggedIn', false);
                              AppRoutes.push(
                                  context,
                                  PageTransitionType.bottomToTop,
                                  const SignInScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(45.r),
                              ),
                              height: 55.h,
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    text(
                                      context,
                                      'Logout',
                                      18.sp,
                                      boldText: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  Widget switchButton() {
    return FlutterSwitch(
      width: 90.0,
      height: 40.0,
      toggleSize: 45.0,
      value: isSwitchOn,
      borderRadius: 30.0,
      padding: 2.0,
      toggleColor: !isSwitchOn ? AppColor.lightGreybg : AppColor.primaryColor,
      switchBorder: Border.all(
        color: AppColor.primaryColor,
        width: 4.0,
      ),
      toggleBorder: Border.all(
        color: isSwitchOn ? AppColor.lightGreybg : AppColor.primaryColor,
        width: 5.0,
      ),
      activeColor: AppColor.primaryColor,
      inactiveColor: AppColor.lightGreybg,
      onToggle: (val) {
        setState(() {
          isSwitchOn = val;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          if (val == true) {
            AppRoutes.push(context, PageTransitionType.topToBottom,
                const RenterDashBoardScreen());
            setState(() {
              isSwitchOn = false;
            });
          }
        });
      },
    );
  }

  Widget textWidget(textvalue) {
    return Container(
      height: 56.h,
      width: 368.w,
      decoration: BoxDecoration(
          color: AppColor.grayShade, borderRadius: BorderRadius.circular(15.r)),
      child: Align(
        alignment: Alignment.center,
        child: text(
          context,
          textvalue,
          15.sp,
          boldText: FontWeight.w600,
          color: AppColor.blackColor,
        ),
      ),
    );
  }
}
