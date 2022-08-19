import 'package:flutter/material.dart';
import 'BookingList.dart';

class HomePage extends StatefulWidget {
  final AnimationController animationController;
  const HomePage({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Your Bookings'),
          ],
        ),
      ),
      body: Trips(),
    );
  }
}























// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MyTripsScreen extends StatefulWidget {
//   final AnimationController animationController;

//   const MyTripsScreen({Key? key, required this.animationController})
//       : super(key: key);
//   @override
//   _MyTripsScreenState createState() => _MyTripsScreenState();
// }

// class _MyTripsScreenState extends State<MyTripsScreen>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("My Trips Screen"),
//       ),
//     );
//   }
// }
