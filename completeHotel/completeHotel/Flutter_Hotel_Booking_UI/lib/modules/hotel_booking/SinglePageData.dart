import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/text_styles.dart';
import '../hotel_detailes/hotelBookData.dart';

class SinglePageData extends StatefulWidget {
  final String hotelImage;
  final String hotelPrice;
  final String hotelName;
  final String hotellocation;
  const SinglePageData({
    Key? key,
    required this.hotelImage,
    required this.hotelName,
    required this.hotelPrice,
    required this.hotellocation,
  }) : super(key: key);

  @override
  State<SinglePageData> createState() => _SinglePageDataState();
}

class _SinglePageDataState extends State<SinglePageData> {
  Map<String, dynamic> hotelData = {
    'h_name': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _getAppBarUI(),
          // _getSearchBarUI(),
          Container(
            height: 250,
            width: 350,
            child: Image.network(
              widget.hotelImage,
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
                  widget.hotelName,

                  //  widget.roomData.titleTxt,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style:
                      TextStyles(context).getBoldStyle().copyWith(fontSize: 24),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Per night Price: ${widget.hotelPrice}',
                  style: TextStyles(context).getTitleStyle2(),
                ),
                Text('Location: ${widget.hotellocation}'),
              ],
            ),
          ),
          //Padding(
            //padding: const EdgeInsets.only(top: 120, bottom: 0),
            //child:Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //children: [
              // Row(
              //      children:[
              //         RatingBar.builder(
              //         initialRating: 3,
              //         minRating: 1,
              //         direction: Axis.horizontal,
              //         allowHalfRating: true,
              //         itemCount: 5,
              //         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //         itemBuilder: (context, _) => Icon(
              //           Icons.star,
              //           color: Colors.amber,
              //           ),
              //           onRatingUpdate: (rating) {
              //             print(rating);
              //             },
              //             ),
              //      ]
              //   ),
                //SizedBox(height:90),
                Row(
                children:[
                     Expanded(
                    child: ElevatedButton( 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KhaltiPaymentApp(
                                userName: hotelData['h_name'],
                                hotelName: widget.hotelName,
                                hotelPrice: widget.hotelPrice),
                          ),
                        );
                      },
                      child: Text(
                        'Book now',
                        style: TextStyles(context).getRegularStyle(),
                      ),

                      //  => launch(
                      // //     "tel:${controller.allProduct[index].phonenumber.toString()}"),
                      // child: Text('CALL'),
                    ),
                  )
                ],
                ),
              //],
            //),
          //),
        ],
      ),
    );
  }
}
