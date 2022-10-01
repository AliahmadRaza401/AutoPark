// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:parkingapp/All%20Screens/Client%20DashBoard/parking%20Details%20Screen/payment.dart';
// import 'package:parkingapp/custom%20Widgets/custom_Button.dart';
// import 'package:parkingapp/routes/app_Routes.dart';
// import 'package:table_calendar/table_calendar.dart';
// import '../../../custom Widgets/default_Text.dart';
// import '../../../utils/AppColor.dart';
// import 'package:intl/intl.dart';

// class BookParkingDetails extends StatefulWidget {
//   const BookParkingDetails({Key? key}) : super(key: key);

//   @override
//   State<BookParkingDetails> createState() => _BookParkingDetailsState();
// }

// class _BookParkingDetailsState extends State<BookParkingDetails> {
//   String? startTime;
//   String? endTime;
//   TimeOfDay selectedTime = TimeOfDay.now();
//   int _value = 6;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   final kToday = DateTime.now();
//   final kFirstDay = DateTime(1960, 07, 01);
//   final kLastDay = DateTime(2080, 07, 01);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: () {
//             AppRoutes.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back,
//             color: AppColor.blackColor,
//           ),
//         ),
//         title: text(
//           context,
//           'Book Parking Details',
//           29.sp,
//           color: AppColor.blackColor,
//           boldText: FontWeight.w600,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//             left: 5.w,
//             right: 5.w,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 10.w),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: text(
//                     context,
//                     'Select Date',
//                     20.sp,
//                     color: AppColor.blackColor,
//                     boldText: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               // calenderWidget(),
//               // SizedBox(height: 20.h),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 10.w),
//               //   child: Align(
//               //     alignment: Alignment.centerLeft,
//               //     child: text(
//               //       context,
//               //       'Distance',
//               //       20.sp,
//               //       color: AppColor.blackColor,
//               //       boldText: FontWeight.w600,
//               //     ),
//               //   ),
//               // ),
//               // selectRangeWidget(),
//               // SizedBox(height: 20.h),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //     children: [
//               //       text(
//               //         context,
//               //         'Start Hour',
//               //         20.sp,
//               //         color: AppColor.blackColor,
//               //         boldText: FontWeight.w600,
//               //       ),
//               //       text(
//               //         context,
//               //         'End Hour',
//               //         20.sp,
//               //         color: AppColor.blackColor,
//               //         boldText: FontWeight.w600,
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //     children: [
//               //       ElevatedButton(
//               //         onPressed: () {
//               //           _selectStartTimeToAdd(context);
//               //         },
//               //         style: ElevatedButton.styleFrom(
//               //           primary: AppColor.greyColor,
//               //         ),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //             startTime == null
//               //                 ? text(
//               //                     context,
//               //                     'Start Hour',
//               //                     16.sp,
//               //                     color: AppColor.blackColor,
//               //                   )
//               //                 : text(
//               //                     context,
//               //                     startTime,
//               //                     16.sp,
//               //                     color: AppColor.primaryColor,
//               //                   ),
//               //             SizedBox(
//               //               width: 5.w,
//               //             ),
//               //             const Icon(
//               //               Icons.access_time_rounded,
//               //               size: 16,
//               //               color: AppColor.blackColor,
//               //             ),
//               //           ],
//               //         ),
//               //       ),
//               //       ElevatedButton(
//               //         onPressed: () {
//               //           _selectEndTimeToAdd(context);
//               //         },
//               //         style: ElevatedButton.styleFrom(
//               //           primary: AppColor.greyColor,
//               //         ),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //             endTime == null
//               //                 ? text(
//               //                     context,
//               //                     'End Hour',
//               //                     16.sp,
//               //                     color: AppColor.blackColor,
//               //                   )
//               //                 : text(
//               //                     context,
//               //                     endTime,
//               //                     16.sp,
//               //                     color: AppColor.primaryColor,
//               //                   ),
//               //             SizedBox(
//               //               width: 5.w,
//               //             ),
//               //             const Icon(
//               //               Icons.access_time_rounded,
//               //               size: 16,
//               //               color: AppColor.blackColor,
//               //             ),
//               //           ],
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),

//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 10.w, top: 10.h),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: text(
//                     context,
//                     'Total',
//                     20.sp,
//                     color: AppColor.blackColor,
//                     boldText: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 10.w, top: 5.h),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     children: [
//                       text(
//                         context,
//                         '\$8.00',
//                         20.sp,
//                         color: AppColor.primaryColor,
//                         boldText: FontWeight.w600,
//                       ),
//                       text(
//                         context,
//                         '/4 hours',
//                         15.sp,
//                         color: AppColor.greyColor,
//                         boldText: FontWeight.w600,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               elevatedButton(
//                 context,
//                 'Continue',
//                 () {
//                   AppRoutes.push(context, PageTransitionType.bottomToTop,
//                       const PaymentScreen());
//                 },
//               ),
//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget calenderWidget() {
//     return TableCalendar(
//       rowHeight: 35,
//       firstDay: kFirstDay,
//       lastDay: kLastDay,
//       focusedDay: _focusedDay,
//       calendarFormat: _calendarFormat,
//       selectedDayPredicate: (day) {
//         return isSameDay(_selectedDay, day);
//       },
//       onDaySelected: (selectedDay, focusedDay) {
//         if (!isSameDay(_selectedDay, selectedDay)) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//             log(_selectedDay.toString());
//             var date = DateTime.parse(_selectedDay.toString());
//             var formattedDate = "${date.day}-${date.month}-${date.year}";
//             log(formattedDate.toString());
//           });
//         }
//       },
//       onFormatChanged: (format) {
//         if (_calendarFormat != format) {
//           setState(() {
//             _calendarFormat = format;
//           });
//         }
//       },
//       onPageChanged: (focusedDay) {
//         _focusedDay = focusedDay;
//       },
//     );
//   }

//   Widget selectRangeWidget() {
//     return Slider(
//         value: _value.toDouble(),
//         min: 1.0,
//         max: 100.0,
//         divisions: 10,
//         activeColor: AppColor.primaryColor,
//         inactiveColor: AppColor.darkGreyColor,
//         label: 'Distance $_value',
//         onChanged: (double newValue) {
//           setState(() {
//             _value = newValue.round();
//             log(_value.toString());
//           });
//         },
//         semanticFormatterCallback: (double newValue) {
//           return '${newValue.round()} dollars';
//         });
//   }

//   _selectStartTimeToAdd(
//     BuildContext context,
//   ) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT TO TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.primaryColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         startTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $startTime');
//       });
//     }
//     if (timeOfDay != null && timeOfDay == selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         startTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $startTime');
//       });
//     }
//   }

//   _selectEndTimeToAdd(
//     BuildContext context,
//   ) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT TO TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.primaryColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         endTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $endTime');
//       });
//     }
//     if (timeOfDay != null && timeOfDay == selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         endTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $endTime');
//       });
//     }
//   }

//   TextEditingController sttxt = TextEditingController();
//   TextEditingController edtxt = TextEditingController();
//   TextEditingController textVal1 = TextEditingController();
//   TextEditingController textVal2 = TextEditingController();
//   var selectedDate1;
//   var selectedToDate;
//   var selectedTimeTo;
// // var _d1 = DateFormat('yyyy-MM-dd').format(selectedDate1);
//   _selectedToDateTime(BuildContext context, StateSetter dropDownState) async {
//     await _selectDateTo(context, dropDownState);
//     await _selectTimeTo(context, dropDownState);
//   }

//   _selectedDateTime(BuildContext context, StateSetter dropDownState) async {
//     await _selectDate(context, dropDownState);
//     await _selectTime(context, dropDownState);
//   }

//   _selectDate(BuildContext context, StateSetter dropDownState) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate1,
//       firstDate: DateTime(2017),
//       lastDate: DateTime.now(),
//       helpText: "SELECT FROM DATE",
//       fieldHintText: "YEAR/MONTH/DATE",
//       fieldLabelText: "FROM DATE",
//       errorFormatText: "Enter a Valid Date",
//       errorInvalidText: "Date Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (selected != null && selected != selectedDate1) {
//       setState(() {
//         selectedDate1 = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         sttxt.text = "${format.format(selectedDate1).toString()}"
//             " "
//             "${selectedTime.hour}:${selectedTime.minute}:00";
//       });
//     } else if (selected != null && selected == selectedDate1) {
//       setState(() {
//         selectedDate1 = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         sttxt.text = "${format.format(selectedDate1).toString()}"
//             " "
//             "${selectedTime.hour}:${selectedTime.minute}:00";
//       });
//     }
//   }

//   _selectTime(BuildContext context, StateSetter dropDownState) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT FROM TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       dropDownState(() {
//         selectedTime = timeOfDay;
//         final format = DateFormat('yyyy-MM-dd');
//         sttxt.text = "${format.format(selectedDate1).toString()}"
//             " "
//             "${selectedTime.hour}:${selectedTime.minute}:00";
//       });
//     }
//   }

//   _selectDateTo(BuildContext context, StateSetter dropDownState) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedToDate,
//       firstDate: selectedDate1,
//       lastDate: DateTime.now(),
//       helpText: "SELECT TO DATE",
//       fieldHintText: "YEAR/MONTH/DATE",
//       fieldLabelText: "TO DATE",
//       errorFormatText: "Enter a Valid Date",
//       errorInvalidText: "Date Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (selected != null && selected != selectedToDate) {
//       setState(() {
//         selectedToDate = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         edtxt.text = "${format.format(selectedToDate).toString()}"
//             " "
//             "${selectedTimeTo.hour}:${selectedTimeTo.minute}:00";
//       });
//     } else if (selected != null && selected == selectedToDate) {
//       setState(() {
//         selectedToDate = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         edtxt.text = "${format.format(selectedToDate).toString()}"
//             " "
//             "${selectedTimeTo.hour}:${selectedTimeTo.minute}:00";
//       });
//     }
//   }

//   _selectTimeTo(BuildContext context, StateSetter dropDownState) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTimeTo,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT TO TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTimeTo) {
//       dropDownState(() {
//         selectedTimeTo = timeOfDay;
//         final format = DateFormat('yyyy-MM-dd');
//         edtxt.text = "${format.format(selectedToDate).toString()}"
//             " "
//             "${selectedTimeTo.hour}:${selectedTimeTo.minute}:00";
//       });
//     }
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/parking%20Details%20Screen/payment.dart';
import 'package:parkingapp/custom%20Widgets/custom_Button.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/customTimeWidget.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:provider/provider.dart';
import '../../../custom Widgets/default_Text.dart';
import '../../../utils/appColor.dart';
import 'reviewSummery.dart';

class BookParkingDetails extends StatefulWidget {
  const BookParkingDetails({Key? key}) : super(key: key);

  @override
  State<BookParkingDetails> createState() => _BookParkingDetailsState();
}

class _BookParkingDetailsState extends State<BookParkingDetails> {
  String? startTime;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    GetAllParkingProvider allParkingProvider =
        Provider.of<GetAllParkingProvider>(context);

    allParkingProvider.startParkingDateTime != null &&
            allParkingProvider.endParkingDateTime != null
        ? allParkingProvider.timeDifference()
        : const SizedBox();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
        title: text(
          context,
          'Book Parking Details',
          29.sp,
          color: AppColor.blackColor,
          boldText: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: text(
                    context,
                    'Select Date',
                    20.sp,
                    color: AppColor.blackColor,
                    boldText: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        DateFormCustom().getDateNow(context).then((value) {
                          log('Value = $value');
                          allParkingProvider.setprkingstartDateTime(value);
                        });
                      },
                      child: Container(
                        height: 130.h,
                        // width: 150.w,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColor.grayShade.withOpacity(0.8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Lottie.asset(
                              'assets/jsonFiles/calenderTime.json',
                              animate: true,
                              repeat: true,
                              fit: BoxFit.cover,
                            ),
                            text(
                              context,
                              allParkingProvider.startParkingDateTime == null
                                  ? 'Starting Date Time'
                                  : allParkingProvider.startParkingDateTime,
                              allParkingProvider.startParkingDateTime == null
                                  ? 15.sp
                                  : 12.sp,
                              color: AppColor.blackColor,
                              boldText: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 5.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        DateFormCustom().getDateNow(context).then((value) {
                          log('Value = $value');
                          allParkingProvider.setprkingEndDateTime(value);
                        });
                      },
                      child: Container(
                        height: 130.h,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColor.grayShade.withOpacity(0.8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Lottie.asset(
                              'assets/jsonFiles/calenderTime.json',
                              animate: true,
                              repeat: true,
                              fit: BoxFit.cover,
                            ),
                            text(
                              context,
                              allParkingProvider.endParkingDateTime == null
                                  ? 'Ending Date Time'
                                  : allParkingProvider.endParkingDateTime,
                              allParkingProvider.endParkingDateTime == null
                                  ? 15.sp
                                  : 12.sp,
                              color: AppColor.blackColor,
                              boldText: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 5.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: text(
                    context,
                    'Total',
                    20.sp,
                    color: AppColor.blackColor,
                    boldText: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      text(
                        context,
                        allParkingProvider.totalPriceofParking == null
                            ? '0'
                            : '\$${allParkingProvider.totalPriceofParking}',
                        20.sp,
                        color: AppColor.primaryColor,
                        boldText: FontWeight.w600,
                      ),
                      text(
                        context,
                        allParkingProvider.totalPrkingTime == null
                            ? '/0'
                            : '/${allParkingProvider.totalPrkingTime}',
                        15.sp,
                        color: AppColor.greyColor,
                        boldText: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              elevatedButton(
                context,
                'Continue',
                () {
                  if (allParkingProvider.totalPrkingTime == null &&
                      allParkingProvider.totalPriceofParking == null) {
                    ToastUtils.showCustomToast(
                      context,
                      "Select Parking Start and Ending Time First !!!!",
                      AppColor.primaryColor,
                    );
                  } else {
                    AppRoutes.push(context, PageTransitionType.bottomToTop,
                        const ReviewSummery());
                  }
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

//   Widget calenderWidget() {
//     return TableCalendar(
//       rowHeight: 35,
//       firstDay: kFirstDay,
//       lastDay: kLastDay,
//       focusedDay: _focusedDay,
//       calendarFormat: _calendarFormat,
//       selectedDayPredicate: (day) {
//         return isSameDay(_selectedDay, day);
//       },
//       onDaySelected: (selectedDay, focusedDay) {
//         if (!isSameDay(_selectedDay, selectedDay)) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//             log(_selectedDay.toString());
//             var date = DateTime.parse(_selectedDay.toString());
//             var formattedDate = "${date.day}-${date.month}-${date.year}";
//             log(formattedDate.toString());
//           });
//         }
//       },
//       onFormatChanged: (format) {
//         if (_calendarFormat != format) {
//           setState(() {
//             _calendarFormat = format;
//           });
//         }
//       },
//       onPageChanged: (focusedDay) {
//         _focusedDay = focusedDay;
//       },
//     );
//   }

//   Widget selectRangeWidget() {
//     return Slider(
//         value: _value.toDouble(),
//         min: 1.0,
//         max: 100.0,
//         divisions: 10,
//         activeColor: AppColor.primaryColor,
//         inactiveColor: AppColor.darkGreyColor,
//         label: 'Distance $_value',
//         onChanged: (double newValue) {
//           setState(() {
//             _value = newValue.round();
//             log(_value.toString());
//           });
//         },
//         semanticFormatterCallback: (double newValue) {
//           return '${newValue.round()} dollars';
//         });
//   }

//   _selectStartTimeToAdd(
//     BuildContext context,
//   ) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT TO TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.primaryColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         startTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $startTime');
//       });
//     }
//     if (timeOfDay != null && timeOfDay == selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         startTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $startTime');
//       });
//     }
//   }

//   _selectEndTimeToAdd(
//     BuildContext context,
//   ) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT TO TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.primaryColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         endTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $endTime');
//       });
//     }
//     if (timeOfDay != null && timeOfDay == selectedTime) {
//       setState(() {
//         log(timeOfDay.toString());

//         log(selectedTime.toString());
//         endTime = "${timeOfDay.hour}:${timeOfDay.minute}:00";
//         log('data =  $endTime');
//       });
//     }
//   }

//   TextEditingController sttxt = TextEditingController();
//   TextEditingController edtxt = TextEditingController();
//   TextEditingController textVal1 = TextEditingController();
//   TextEditingController textVal2 = TextEditingController();
//   var selectedDate1;
//   var selectedToDate;
//   var selectedTimeTo;
// // var _d1 = DateFormat('yyyy-MM-dd').format(selectedDate1);
//   _selectedToDateTime(BuildContext context, StateSetter dropDownState) async {
//     await _selectDateTo(context, dropDownState);
//     await _selectTimeTo(context, dropDownState);
//   }

//   _selectedDateTime(BuildContext context, StateSetter dropDownState) async {
//     await _selectDate(context, dropDownState);
//     await _selectTime(context, dropDownState);
//   }

//   _selectDate(BuildContext context, StateSetter dropDownState) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate1,
//       firstDate: DateTime(2017),
//       lastDate: DateTime.now(),
//       helpText: "SELECT FROM DATE",
//       fieldHintText: "YEAR/MONTH/DATE",
//       fieldLabelText: "FROM DATE",
//       errorFormatText: "Enter a Valid Date",
//       errorInvalidText: "Date Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (selected != null && selected != selectedDate1) {
//       setState(() {
//         selectedDate1 = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         sttxt.text = "${format.format(selectedDate1).toString()}"
//             " "
//             "${selectedTime.hour}:${selectedTime.minute}:00";
//       });
//     } else if (selected != null && selected == selectedDate1) {
//       setState(() {
//         selectedDate1 = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         sttxt.text = "${format.format(selectedDate1).toString()}"
//             " "
//             "${selectedTime.hour}:${selectedTime.minute}:00";
//       });
//     }
//   }

//   _selectTime(BuildContext context, StateSetter dropDownState) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT FROM TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       dropDownState(() {
//         selectedTime = timeOfDay;
//         final format = DateFormat('yyyy-MM-dd');
//         sttxt.text = "${format.format(selectedDate1).toString()}"
//             " "
//             "${selectedTime.hour}:${selectedTime.minute}:00";
//       });
//     }
//   }

//   _selectDateTo(BuildContext context, StateSetter dropDownState) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedToDate,
//       firstDate: selectedDate1,
//       lastDate: DateTime.now(),
//       helpText: "SELECT TO DATE",
//       fieldHintText: "YEAR/MONTH/DATE",
//       fieldLabelText: "TO DATE",
//       errorFormatText: "Enter a Valid Date",
//       errorInvalidText: "Date Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (selected != null && selected != selectedToDate) {
//       setState(() {
//         selectedToDate = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         edtxt.text = "${format.format(selectedToDate).toString()}"
//             " "
//             "${selectedTimeTo.hour}:${selectedTimeTo.minute}:00";
//       });
//     } else if (selected != null && selected == selectedToDate) {
//       setState(() {
//         selectedToDate = selected;
//         final format = DateFormat('yyyy-MM-dd');
//         edtxt.text = "${format.format(selectedToDate).toString()}"
//             " "
//             "${selectedTimeTo.hour}:${selectedTimeTo.minute}:00";
//       });
//     }
//   }

//   _selectTimeTo(BuildContext context, StateSetter dropDownState) async {
//     TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTimeTo,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "SELECT TO TIME",
//       errorInvalidText: "Time Out of Range",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.darkGreyColor, // header background color
//               onPrimary: AppColor.whiteColor, // header text color
//               onSurface: AppColor.primaryColor, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (timeOfDay != null && timeOfDay != selectedTimeTo) {
//       drop