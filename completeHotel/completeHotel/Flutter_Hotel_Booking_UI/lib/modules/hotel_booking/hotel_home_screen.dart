import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/modules/hotel_booking/SinglePageData.dart';
import 'package:flutter_hotel_booking_ui/modules/hotel_booking/controller/data_controller.dart';
import 'package:get/get.dart';
import '../profile/profile_screen.dart';
import 'package:flutter_hotel_booking_ui/utils/text_styles.dart';
// import 'addHotel.dart';

class HotelHomeScreen extends StatefulWidget {
  DataController controller = Get.put(DataController());
  final AnimationController animationController;
  HotelHomeScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _animationController;
  ScrollController scrollController = new ScrollController();
  // int room = 1;
  // int ad = 2;
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(Duration(days: 5));
  bool _isShowMap = false;

  final searchBarHieght = 158.0;
  final filterBarHieght = 52.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        _animationController.animateTo(0.0);
      } else if (scrollController.offset > 0.0 &&
          scrollController.offset < searchBarHieght) {
        // we need around searchBarHieght scrolling values in 0.0 to 1.0
        _animationController
            .animateTo((scrollController.offset / searchBarHieght));
      } else {
        _animationController.animateTo(1.0);
      }
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Explore',
        style: TextStyles(context).getExplore(),
      )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => HotelHomeScreen(animationController: _animationController,),
                 ),
              ),
            ),
            createDrawerBodyItem(icon: Icons.account_circle, text: 'Profile',
            onTap: () =>  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ProfilePage(),
                ),
              ),),
            createDrawerBodyItem(icon: Icons.event_note, text: 'Events'),
            Divider(),
            ListTile(
              title: Text('App version 1.0.0'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.allProduct.isEmpty
            ? Center(
                child: Text('NO HOTEL FOUND '),
              )
            : ListView.builder(
                itemCount: controller.allProduct.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        // _getAppBarUI(),
                        // _getSearchBarUI(),
                        Container(
                          height: 250,
                          width: 350,
                          child: Image.network(
                            controller.allProduct[index].productimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                controller.allProduct[index].productname,

                                //  widget.roomData.titleTxt,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyles(context)
                                    .getBoldStyle()
                                    .copyWith(fontSize: 24),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Per night Price: ${controller.allProduct[index].productprice.toString()}',
                                style: TextStyles(context).getTitleStyle2(),
                              ),
                              Text(
                                'Hotel location: ${controller.allProduct[index].productlocation.toString()}',
                                style: TextStyles(context).getTitleStyle2(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    var hotelprice = controller
                                        .allProduct[index].productprice
                                        .toString();
                                    var hotelname = controller
                                        .allProduct[index].productname;
                                    var hotelImage = controller
                                        .allProduct[index].productimage;
                                    var hotellocation = controller
                                        .allProduct[index].productlocation;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SinglePageData(
                                            hotelImage: hotelImage,
                                            hotelName: hotelname,
                                            hotellocation: hotellocation,
                                            hotelPrice: hotelprice),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Check details',
                                    style:
                                        TextStyles(context).getRegularStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),

    );
  }

  // Widget _getAppBarUI() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         // top: MediaQuery.of(context).padding.top, left: 8, right: 8
  //         ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
          
  //         Container(
  //           width: AppBar().preferredSize.height + 0,
  //           height: AppBar().preferredSize.height,
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.end,
              
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
              fit: BoxFit.fill, image: AssetImage('images/city_6.jpg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Welcome to Travazo",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}
