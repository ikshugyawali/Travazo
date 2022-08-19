import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'addHotel_Screen.dart';
import 'controller.dart/data_controller.dart';
import 'hostProduct.dart';

class HotelHomeScreen extends StatefulWidget {
  DataController controller = Get.put(DataController());
  HotelHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  // int ad = 2;
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(Duration(days: 5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Explore',
        // style: TextStyles(context).getExplore(),
      )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            createDrawerBodyItem(
              icon: Icons.home,
              text: 'EditHotel',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostEdit(),
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text('App version 1.0.0'),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: AddHotel(),

      // appBar: AppBar(
      //     title: Text(
      //   'Explore',
      // )),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       createDrawerHeader(),
      //       createDrawerBodyItem(
      //         icon: Icons.home,
      //         text: 'AddHotel',
      //         onTap: () => Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => AddHotel(),
      //           ),
      //         ),
      //       ),
      //       createDrawerBodyItem(icon: Icons.account_circle, text: 'Profile'),
      //       createDrawerBodyItem(icon: Icons.event_note, text: 'Events'),
      //       Divider(),
      //       ListTile(
      //         title: Text('App version 1.0.0'),
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('images/bg_header.jpeg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Welcome to Host Panel",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}
