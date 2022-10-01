import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/signUp/signUp.dart';
import 'package:parkingapp/custom%20Widgets/custom_Button.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/firebaseService/suthenticationService.dart';
import 'package:parkingapp/providers/authentication_Provider.dart';
import 'package:parkingapp/providers/loadingProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:provider/provider.dart';

import '../../custom Widgets/alert_dialogs/custom_Alertdialog.dart';
import '../chose Screen/choseScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool textVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  late AuthenticationProvider authenticationProviderProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationProviderProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(builder: (context, prov, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: text(
                    context,
                    'Log In',
                    45.sp,
                    boldText: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                field(
                  const Icon(Icons.mail),
                  "Email",
                  0xffF2F2F7,
                  0xff929292,
                  _email,
                ),
                passwordField(
                  "Password",
                  _password,
                ),
                SizedBox(
                  height: 50.h,
                ),
                prov.loading
                    ? const CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      )
                    : elevatedButton(
                        context,
                        'Sign IN',
                        () async {
                          if (_formKey.currentState!.validate()) {
                            var result =
                                await authenticationProviderProvider.signIn(
                                    context,
                                    _email.text.trim(),
                                    _password.text);
                            if (result == true) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                showCustomDialog(
                                  context,
                                  'Congratulations!',
                                  'Login Successfully',
                                  'assets/jsonFiles/successful.json',
                                );
                              });
                            } else {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                showNoLoginCustomDialog(
                                  context,
                                  'Opps!',
                                  'Crendtials Not Match...',
                                  // ChoseScreen(),
                                  // () {
                                  //   // AppRoutes.pushAndRemoveUntil(
                                  //   //     context,
                                  //   //     PageTransitionType.bottomToTop,
                                  //   //     const ChoseScreen());
                                  // },
                                  'assets/jsonFiles/failed.json',
                                );
                              });
                            }
                          }
                        },
                      ),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(
                      context,
                      'Dosn\'t have an account?   ',
                      16.sp,
                      color: AppColor.darkGreyColor,
                      boldText: FontWeight.w400,
                    ),
                    GestureDetector(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.bottomToTop,
                              const SignUpScreen());
                        },
                        child: text(
                          context,
                          'SignUp',
                          16.sp,
                          boldText: FontWeight.w700,
                          color: AppColor.primaryColor,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget field(
    Icon icondata,
    String hintText,
    _textFieldColor,
    _hintColor,
    TextEditingController cont,
  ) {
    return Container(
      width: 370.w,
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: TextFormField(
        controller: cont,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Email is required'),
          EmailValidator(errorText: "Enter valid email address")
        ]),
        decoration: InputDecoration(
          fillColor: AppColor.greyColor,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: const BorderSide(
                width: 2,
                color: AppColor.primaryColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              )),
          filled: true,
          prefixIcon: icondata,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 10.w,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(_hintColor),
          ),
        ),
      ),
    );
  }

  Widget passwordField(
    String hintText,
    TextEditingController cont,
  ) {
    return Container(
      width: 370.w,
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: TextFormField(
        // : Theme.of(context)
        //                           .copyWith(primaryColor: Colors.redAccent,),
        cursorColor: AppColor.primaryColor,
        obscureText: textVisible,
        validator: RequiredValidator(errorText: 'password is required'),
        controller: cont,
        decoration: InputDecoration(
          fillColor: AppColor.greyColor,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: const BorderSide(
                width: 2,
                color: AppColor.primaryColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              )),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                textVisible = !textVisible;
              });
            },
            child: textVisible
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 10.w,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xff929292),
          ),
        ),
      ),
    );
  }
}
