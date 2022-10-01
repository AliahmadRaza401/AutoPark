import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/customerBottomBar/customerBottomBar.dart';
import 'package:parkingapp/custom%20Widgets/alert_dialogs/custom_Alertdialog.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:parkingapp/routes/app_Routes.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/constFile.dart';
import 'package:parkingapp/utils/customToast.dart';
import 'package:provider/provider.dart';

import '../All Screens/Client DashBoard/clientFirebaseService.dart';

class PaymentProvider with ChangeNotifier {
  // late BuildContext context;

  // init({required BuildContext context}) {
  //   this.context = context;
  // }

  bool userProfileloading = false;

  setLoading(bool value) {
    userProfileloading = value;
    // notifyListeners();
  }

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(
    ammountvalue,
    BuildContext context,
  ) async {
    try {
      paymentIntent = await createPaymentIntent(
        ammountvalue.toString(),

        // '10',
        'USD',
        context,
      );
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {
        displayPaymentSheet(
          context,
        );
      });

      ///now finally display payment sheeet

    } catch (e, s) {
      log('exception:$e$s');
      // ToastUtils.showCustomToast(
      //     context, 'Error : $e$s', AppColor.primaryColor);
    }
  }

  displayPaymentSheet(
    BuildContext context,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        ClientFirebaseService.bookParking(
          context,
        );
        // log('Parking Bokked');
        // AppRoutes.pushAndRemoveUntil(
        // context, PageTransitionType.bottomToTop, const MyNavigationBar());
        showCustomDialog(
          context,
          'Congratulations!',
          'Parking Booked Successfully',
          'assets/jsonFiles/successful.json',
        );
        // showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //           content: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Row(
        //                 children: const [
        //                   Icon(
        //                     Icons.check_circle,
        //                     color: Colors.green,
        //                   ),
        //                   Text("Payment Successfull"),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
        // AppRoutes.pop(context);
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
        // ToastUtils.showCustomToast(
        //     context, 'Error : $error $stackTrace', AppColor.primaryColor);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('Error $e');
      // ToastUtils.showCustomToast(context, 'Error : $e', AppColor.primaryColor);
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(
    String amount,
    String currency,
    BuildContext context,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('Error = $err');
      // ToastUtils.showCustomToast(
      //     context, 'Error : $err', AppColor.primaryColor);
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
