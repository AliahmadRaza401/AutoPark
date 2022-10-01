import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/firebaseService/suthenticationService.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/providers/loadingProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:parkingapp/utils/imagePickerService.dart';
import 'package:parkingapp/utils/textFieldValidator.dart';
import 'package:provider/provider.dart';
import '../../custom Widgets/alert_dialogs/custom_Alertdialog.dart';
import '../../custom Widgets/custom_Button.dart';
import '../../custom Widgets/default_Text.dart';
import '../../providers/authentication_Provider.dart';
import '../singIn/signIn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool textVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoadingProvider loadindProvider = LoadingProvider();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  var _image;

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authenticationProviderProvider =
        Provider.of<AuthenticationProvider>(context);
    return Consumer<LoadingProvider>(builder: (context, prov, _) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: InkWell(
              onTap: () {
                AppRoutes.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center/,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(
                    context,
                    'Create Your Account',
                    45.sp,
                    boldText: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        openFilePicker();
                      },
                      child: _image != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_image!),
                            )
                          : const Image(
                              image: AssetImage(AppImages.proPic),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  nameTextField(
                    const Icon(Icons.person),
                    "Name",
                    0xffF2F2F7,
                    0xff929292,
                    _name,
                  ),
                  emailTextField(
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
                  phoneTextField(
                    const Icon(Icons.phone),
                    "phone",
                    0xffF2F2F7,
                    0xff929292,
                    _phoneNumber,
                  ),
                  // Expanded(
                  //   child: Container(),
                  // ),
                  prov.loading
                      ? const CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        )
                      : elevatedButton(
                          context,
                          'Sign Up',
                          () async {
                            if (_image == null) {
                              ToastUtils.showCustomToast(context,
                                  "Error \n Image is Missing", Colors.red);
                            } else {
                              if (_formKey.currentState!.validate() &&
                                  _image != null) {
                                var result =
                                    await authenticationProviderProvider.signUp(
                                  context,
                                  _email.text,
                                  _password.text,
                                  _name.text,
                                  _phoneNumber.text,
                                  _image,
                                );

                                if (result == true) {
                                  showCustomDialog(
                                    context,
                                    'Congratulations!',
                                    'Account Created Successfully',
                                    'assets/jsonFiles/successful.json',
                                  );
                                } else {
                                  showNoSignUPCustomDialog(
                                    context,
                                    'Opps!',
                                    authenticationProviderProvider.errorMessage,
                                    'assets/jsonFiles/failed.json',
                                  );
                                }
                              }
                            }
                          },
                        ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(
                        context,
                        'Already have an account?   ',
                        16.sp,
                        color: AppColor.darkGreyColor,
                        boldText: FontWeight.w400,
                      ),
                      GestureDetector(
                          onTap: () {
                            AppRoutes.push(
                                context,
                                PageTransitionType.bottomToTop,
                                const SignInScreen());
                          },
                          child: text(
                            context,
                            'SignIn',
                            16.sp,
                            boldText: FontWeight.w700,
                            color: AppColor.primaryColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget emailTextField(
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
        validator: MultiValidator(TextValidator.emailValidator
            // [
            //   RequiredValidator(errorText: 'Email is required'),
            //   EmailValidator(errorText: "Enter valid email address")
            // ],
            ),
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

  Widget phoneTextField(
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
      child: IntlPhoneField(
        controller: cont,
        validator: MultiValidator(
          TextValidator.phoneValidator,
        ),
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
        initialCountryCode: 'pk',
      ),
    );
  }

  Widget nameTextField(
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
        validator: MultiValidator(
          TextValidator.nameValidator,
        ),
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
        cursorColor: AppColor.primaryColor,
        obscureText: textVisible,
        validator: MultiValidator(TextValidator.passwordValidator),
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

  Future<void> openFilePicker() async {
    log("File Picker");
    var image = await pickImageFromGalleryOrCamera(context);
    if (image == null) return;
    setState(() {
      _image = image;
    });
  }
}
