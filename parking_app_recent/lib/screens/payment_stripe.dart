// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// //import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
// // import 'package:stripe_payment/stripe_payment.dart';
// import 'package:http/http.dart' as http;
//
// class Payment extends StatefulWidget {
//   @override
//   _PaymentState createState() => _PaymentState();
// }
//
// class _PaymentState extends State<Payment> {
//   // String _paymentMethodId;
//   // String _errorMessage = "";
//   //final _stripePayment = FlutterStripePayment();
//
// //this uri is coming from backend.....
//
//   final uri = '';
//
//   double amount = 100.0;
//
//   @override
//   void initState() {
//     super.initState();
//     StripePayment.setOptions(StripeOptions(
//       publishableKey:
//           'pk_test_51J4EyzAwVIuxKGqbKelvDoe6iyQI3mjBGzaJZhAKjFFEbzSDFHWcFztnXWtycAMKbYxCDVXv3eC2L6sjJdNOBJEM00VNu18JGj',
//     ));
//     // _stripePayment.setStripeSettings(
//     //     "{STRIPE_PUBLISHABLE_KEY}", "{STRIPE_APPLE_PAY_MERCHANTID}");
//     // _stripePayment.onCancel = () {
//     //   print("the payment form was cancelled");
//     // };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Stripe App Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // _paymentMethodId != null
//               //     ? Text(
//               //         "Payment Method Returned is $_paymentMethodId",
//               //         textAlign: TextAlign.center,
//               //       )
//               //     : Container(
//               //         child: Text(_errorMessage),
//               //       ),
//               ElevatedButton(
//                 child: Text("Add Card"),
//                 onPressed: () async {
//                   startPayment();
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> startPayment() async {
//     StripePayment.setStripeAccount(null);
//     amount = 100;
//     PaymentMethod method = PaymentMethod();
//     method = await StripePayment.paymentRequestWithCardForm(
//       CardFormPaymentRequest(),
//     ).then((paymentMethod) => paymentMethod).catchError((onError) {
//       print(onError);
//     });
//     startDirectCharges(method);
//   }
//
//   Future<void> startDirectCharges(PaymentMethod method) async {
//     final response = await http.post(Uri.parse(uri));
//     if (response.body != null) {
//       final paymentIntent = jsonDecode(response.body);
//       final status = paymentIntent['paymentIntent']['status'];
//       final acct = paymentIntent['stripeAccount'];
//
//       if (status == 'succeeded') {
//         print('payment done');
//       } else {
//         StripePayment.setStripeAccount(acct);
//         await StripePayment.confirmPaymentIntent(
//           PaymentIntent(
//             clientSecret: paymentIntent['paymentIntent']['client_secret'],
//             paymentMethod: paymentIntent['paymentIntent']['payment_method'],
//           ),
//         ).then((paymentIntentResult) {
//           final paymentStatus = paymentIntentResult.status;
//           if (paymentStatus == 'succeeded') {
//             print('Payment done');
//           }
//         });
//       }
//     }
//   }
// }
