import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:parkingapp/All%20Screens/Renter%20Dashboard/Renter%20Firebase%20Service/renterFirebaseService.dart';
import 'package:parkingapp/custom%20Widgets/default_Text.dart';
import 'package:parkingapp/images/appImages.dart';
import 'package:parkingapp/providers/loadingProvider.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/constFile.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:parkingapp/utils/imagePickerService.dart';
import 'package:parkingapp/utils/textFieldValidator.dart';
import 'package:provider/provider.dart';
import '../../../custom Widgets/custom_Button.dart';

class PostParkingScreen extends StatefulWidget {
  const PostParkingScreen({Key? key}) : super(key: key);

  @override
  State<PostParkingScreen> createState() => _PostParkingScreenState();
}

class _PostParkingScreenState extends State<PostParkingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController parkingNameController = TextEditingController();
  TextEditingController potalCodeController = TextEditingController();
  TextEditingController parkingPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late LatLng currentLaltg;
  var renterCurrentLoaction;
  var parkingAddressLat;
  var parkingAddressLong;
  String? renteraddress;
  bool smallType = true;
  bool largeType = false;
  bool garageValue = false;
  bool roofValue = false;
  Color checkBoxFillColor = AppColor.primaryColor;
  var _image;

  @override
  void initState() {
    locatePosition();
    super.initState();
  }

  locatePosition() async {
    log('i am in the location function');
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    LocationPermission status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      log("Location is Off =======================>>");
    } else {
      log("Location is ON =======================>>");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      log('position: $position');
      setState(() {
        currentLaltg = LatLng(position.latitude, position.longitude);
        log('currentLaltg: $currentLaltg');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(builder: (context, prov, _) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                AppRoutes.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              )),
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          title: text(
            context,
            'Location details',
            30.sp,
            color: AppColor.blackColor,
            boldText: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                    apiKey: googleApikey,
                                    hintText: "Find a place ...",
                                    searchingText: "Please wait ...",
                                    selectText: "Select place",
                                    outsideOfPickAreaText: "Place not in area",
                                    initialPosition: currentLaltg != null
                                        ? currentLaltg
                                        : _center,
                                    useCurrentLocation: true,
                                    selectInitialPosition: true,
                                    usePinPointingSearch: true,
                                    usePlaceDetailSearch: true,
                                    onPlacePicked: (result) {
                                      renterCurrentLoaction = result;
                                      Navigator.of(context).pop();
                                      setState(() {
                                        log(renterCurrentLoaction
                                            .formattedAddress);
                                        log(renterCurrentLoaction
                                            .geometry!.location.lat
                                            .toString());
                                        log(renterCurrentLoaction
                                            .geometry!.location.lng
                                            .toString());

                                        renteraddress = renterCurrentLoaction
                                            .formattedAddress;

                                        parkingAddressLat =
                                            renterCurrentLoaction
                                                .geometry!.location.lat;
                                        parkingAddressLong =
                                            renterCurrentLoaction
                                                .geometry!.location.lng;

                                        log('parkingAddressLong = $parkingAddressLong');
                                        log('parkingAddressLat = $parkingAddressLat');
                                        log('renteraddress = $renteraddress');
                                      });
                                    })),
                          );
                        },
                        child: renteraddress == null
                            ? parkingLoacationPicker('Enter Parking Loaction')
                            : parkingLoacationPicker(renterCurrentLoaction
                                .formattedAddress
                                .toString()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  parkingnameTextField(
                    const Icon(Icons.car_repair_outlined),
                    "Parking Name",
                    0xffF2F2F7,
                    0xff929292,
                    parkingNameController,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  nameTextField(
                    const Icon(Icons.location_city),
                    "Postal Code",
                    0xffF2F2F7,
                    0xff929292,
                    potalCodeController,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      'Select Parking Type',
                      24.sp,
                      boldText: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            smallType = true;
                            largeType = false;
                          });
                        },
                        child: parkingTypeWidget(
                          'Small',
                          AppImages.smallParking,
                          smallType,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            smallType = false;
                            largeType = true;
                          });
                        },
                        child: parkingTypeWidget(
                          'Large',
                          AppImages.largeParking,
                          largeType,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      'Parking details',
                      24.sp,
                      boldText: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        context,
                        'Garage',
                        18.sp,
                        boldText: FontWeight.w300,
                        color: AppColor.darkGreyColor,
                      ),
                      Checkbox(
                        fillColor:
                            MaterialStateProperty.all(AppColor.primaryColor),
                        value: garageValue,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            garageValue = value!;
                            log('garageValue: $garageValue');
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        context,
                        'Roof',
                        18.sp,
                        boldText: FontWeight.w300,
                        color: AppColor.darkGreyColor,
                      ),
                      Checkbox(
                        fillColor:
                            MaterialStateProperty.all(AppColor.primaryColor),
                        value: roofValue,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            roofValue = value!;
                            log('roofValue: $roofValue');
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      'Description',
                      24.sp,
                      boldText: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  descriptionTextFieldWidget(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                      context,
                      'Select Parking',
                      24.sp,
                      boldText: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        openFilePicker();
                      },
                      child: _image != null
                          ? Container(
                              // padding: EdgeInsets.all(10.h),
                              height: 110.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(
                                      _image!,
                                    ),
                                    fit: BoxFit.cover),
                                color: AppColor.greyColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            )
                          : Container(
                              height: 110.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                color: AppColor.lightGreybg,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload_file,
                                    color: AppColor.darkGreyColor,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: text(
                                      context,
                                      'Please Select Parking Image',
                                      15.sp,
                                      color: AppColor.darkGreyColor,
                                      // boldText: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  priceTextField(
                    const Icon(Icons.payment),
                    "Parking Price per Hour",
                    0xffF2F2F7,
                    0xff929292,
                    parkingPriceController,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  prov.loading
                      ? const CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        )
                      : elevatedButton(
                          context,
                          'Finish',
                          () {
                            if (renteraddress == null && _image != null) {
                              ToastUtils.showCustomToast(
                                  context,
                                  "Error \n Parking Location OR Image  is Missing",
                                  Colors.red);
                            } else {
                              if (_formKey.currentState!.validate() &&
                                  renteraddress != null) {
                                log(renteraddress!);
                                log(potalCodeController.text);

                                log(garageValue.toString());
                                log(roofValue.toString());
                                log(descriptionController.text);
                                log('Post Parking Address ');
                                log('Post Parking Address lat =$parkingAddressLat ');
                                log('Post Parking Address long =$parkingAddressLong ');
                                RenterFirebaseService
                                    .postParkingDetailsToFirestore(
                                  context,
                                  renteraddress!,
                                  parkingAddressLat,
                                  parkingAddressLong,
                                  potalCodeController.text,
                                  smallType ? "Small" : "Large",
                                  garageValue,
                                  roofValue,
                                  descriptionController.text,
                                  _image,
                                  parkingNameController.text,
                                  parkingPriceController.text,
                                );
                              }
                            }
                          },
                        ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget descriptionTextFieldWidget() {
    return TextFormField(
      controller: descriptionController,
      validator: MultiValidator(
        TextValidator.descriptionValidator,
      ),
      decoration: InputDecoration(
        fillColor: AppColor.lightGreybg,
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

        // prefixIcon: icondata,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        hintText: 'Enter Description',
        hintStyle: const TextStyle(
          color: Color(0xff929292),
        ),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
    );
  }

  Widget parkingTypeWidget(
    textVal,
    imageValue,
    bool type,
  ) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: type ? AppColor.primaryColor : AppColor.greyColor,
            width: 1,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40.h,
            width: 50.w,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(imageValue),
            )),
          ),
          SizedBox(
            width: 20.w,
          ),
          text(
            context,
            textVal,
            16.sp,
            boldText: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget parkingnameTextField(
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
        keyboardType: TextInputType.name,
        controller: cont,
        validator: MultiValidator(
          TextValidator.nameValidator,
        ),
        decoration: InputDecoration(
          fillColor: Colors.transparent,
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
                color: AppColor.greyColor,
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

  Widget priceTextField(
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
        keyboardType: TextInputType.number,
        controller: cont,
        validator: MultiValidator(
          TextValidator.priceValidator,
        ),
        decoration: InputDecoration(
          fillColor: Colors.transparent,
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
                color: AppColor.greyColor,
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
        keyboardType: TextInputType.number,
        controller: cont,
        validator: MultiValidator(
          TextValidator.postalValidator,
        ),
        decoration: InputDecoration(
          fillColor: Colors.transparent,
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
                color: AppColor.greyColor,
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

  Widget parkingLoacationPicker(
    loacationStringAddress,
  ) {
    return Container(
      width: 323.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColor.greyColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 10.h,
        left: 4.w,
        right: 4.w,
      ),
      child: Row(
        children: [
          const Image(image: AssetImage(AppImages.locationMarker)),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Text(
              loacationStringAddress,
              style: const TextStyle(
                  fontFamily: 'Encode Sans',
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xff606060,
                  )),
            ),
          )
        ],
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
