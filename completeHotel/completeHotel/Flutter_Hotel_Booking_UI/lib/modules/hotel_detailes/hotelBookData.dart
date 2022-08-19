import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:khalti/khalti.dart';
import 'khalti_payment_page.dart';

// void main() => runApp(const KhaltiPaymentApp());

class KhaltiPaymentApp extends StatelessWidget {
  final String hotelName;
  final String hotelPrice;
  final String userName;
  const KhaltiPaymentApp(
      {Key? key,
      required this.userName,
      required this.hotelName,
      required this.hotelPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_30e12814fed64afa9a7d4a92a2194aeb",
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            theme: ThemeData(
                primaryColor: const Color(0xFF56328c),
                appBarTheme: const AppBarTheme(
                  color: Color(0xFF56328c),
                )),
            title: 'Khalti Payment',
            home: KhaltiPaymentPage(
              hotelName: hotelName,
              hotelPrice: hotelPrice,
            ),
          );
        });
  }
}
