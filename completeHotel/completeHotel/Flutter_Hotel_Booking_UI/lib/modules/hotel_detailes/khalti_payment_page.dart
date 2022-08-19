// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_hotel_booking_ui/modules/hotel_detailes/room_booking_screen.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../myTrips/BookingList.dart';
import '../myTrips/my_trips_screen.dart';

class KhaltiPaymentPage extends StatefulWidget {
  final String hotelName;
  final String hotelPrice;
  const KhaltiPaymentPage(
      {Key? key, required this.hotelName, required this.hotelPrice})
      : super(key: key);

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();
  //late AnimationController _animationController;

  Book(String hotelName, String price) {
    FirebaseFirestore.instance.collection("HoteBook").add({
      'Hotel': widget.hotelName,
      'Price': widget.hotelPrice,
    });
  }

  getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalti Payment Integration'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            // For Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Enter Amount to pay",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            // For Button
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.red)),
                height: 50,
                color: const Color(0xFF56328c),
                child: const Text(
                  'Pay With Khalti',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  Book('${widget.hotelName}', '${widget.hotelPrice}');

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Trips()),
                  );
                }
                //   KhaltiScope.of(context).pay(
                //     config: PaymentConfig(
                //       amount: getAmt(),
                //       productIdentity: 'dells-sssssg5-g5510-2021',
                //       productName: 'Product Name',
                //     ),
                //     preferences: [
                //       PaymentPreference.khalti,
                //     ],
                //     onSuccess: (su) {
                //       const successsnackBar = SnackBar(
                //         content: Text('Payment Successful'),
                //       );
                //       ScaffoldMessenger.of(context)
                //           .showSnackBar(successsnackBar);
                //     },
                //     onFailure: (fa) {
                //       const failedsnackBar = SnackBar(
                //         content: Text('Payment Failed'),
                //       );
                //       ScaffoldMessenger.of(context)
                //           .showSnackBar(failedsnackBar);
                //     },
                //     onCancel: () {
                //       const cancelsnackBar = SnackBar(
                //         content: Text('Payment Cancelled'),
                //       );
                //       ScaffoldMessenger.of(context)
                //           .showSnackBar(cancelsnackBar);
                //     },
                //   );
                // }),
                )
          ],
        ),
      ),
    );
  }
}
