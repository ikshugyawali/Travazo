import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:flutter_hotel_booking_ui/modules/login/forgot_password.dart';
import 'package:flutter_hotel_booking_ui/modules/login/login_screen.dart';
import 'package:flutter_hotel_booking_ui/modules/login/sign_up_Screen.dart';
import 'package:flutter_hotel_booking_ui/routes/routes.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog: false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  void gotoSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Splash, (Route<dynamic> route) => false);
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.IntroductionScreen,
        (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(Login());
  }

  Future<dynamic> gotoTabScreen() async {
    return await _pushMaterialPageRoute(BottomTabScreen());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(Signup());
  }

  Future<dynamic> gotoForgotPassword() async {
    return await _pushMaterialPageRoute(ForgotPassword());
  }

  // Future<dynamic> gotoSearchScreen() async {
  //   return await _pushMaterialPageRoute(SearchScreen());
  // }

  // Future<dynamic> gotoHotelHomeScreen() async {
  //   return await _pushMaterialPageRoute(HotelHomeScreen());
  // }

  // Future<dynamic> gotoFiltersScreen() async {
  //   return await _pushMaterialPageRoute(FiltersScreen());
  // }

  // Future<dynamic> gotoaddHotel() async {
  //   return await _pushMaterialPageRoute(const MyHomePage(
  //     title: 'hello',
  //   ));
  // }

  //  Future<dynamic> gotoSinglePage() async {
  //   return await _pushMaterialPageRoute(const SinglePage( ));
  // }

//   Future<dynamic> gotoRoomBookingScreen(String hotelname) async {
//     return await _pushMaterialPageRoute(
//         RoomBookingScreen(hotelName: hotelname));
//   }
}
