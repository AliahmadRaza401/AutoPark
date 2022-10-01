// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// import '../../utils/constFile.dart';


// class PaymentScreenNew extends StatefulWidget {
//   const PaymentScreenNew({Key? key}) : super(key: key);

//   @override
//   _PaymentScreenNewState createState() => _PaymentScreenNewState();
// }

// class _PaymentScreenNewState extends State<PaymentScreenNew> {

//   Map<String, dynamic>? paymentIntent;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stripe Payment'),
//       ),
//       body: Center(
//         child: TextButton(
//           child: const Text('Make Payment'),
//           onPressed: ()async{
//             await makePayment();
//           },
//           ),
//       ),
//     );
//   }



// }