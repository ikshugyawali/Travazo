import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'cancelBooking.dart';

class Trips extends StatefulWidget {
  const Trips({
    Key? key,
  }) : super(key: key);
  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  final Stream<QuerySnapshot> HotelBookingStream =
      FirebaseFirestore.instance.collection('HoteBook').snapshots();

  // For Deleting User
  CollectionReference HotelBooking =
      FirebaseFirestore.instance.collection('HoteBook');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return HotelBooking.doc(id)
        .delete()
        .then((value) => print('Booking Deleted'))
        .catchError((error) => print('Failed to Delete Booking: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: HotelBookingStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Material(
                       child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              1: FixedColumnWidth(140),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      color: Colors.greenAccent,
                                      child: Center(
                                        child: Text(
                                          'Hotel',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.greenAccent,
                                      child: Center(
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.greenAccent,
                                      child: Center(
                                        child: Text(
                                          'Action',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              for (var i = 0; i < storedocs.length; i++) ...[
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Center(
                                          child: Text(storedocs[i]['Hotel'],
                                              style: TextStyle(fontSize: 18.0))),
                                    ),
                                    TableCell(
                                      child: Center(
                                          child: Text(storedocs[i]['Price'],
                                              style: TextStyle(fontSize: 18.0))),
                                    ),
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                                {deleteUser(storedocs[i]['id'])},
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
          );
        });
  }
}
