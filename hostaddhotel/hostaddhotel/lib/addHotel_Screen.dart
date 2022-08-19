import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_hotel_booking_ui/modules/hotel_booking/fireBaseAddStore/hotelImage.dart';
import 'package:get/get.dart';

import 'controller.dart/data_controller.dart';
import 'hotelImage.dart';

class AddHotel extends StatefulWidget {
  // DataController controller = Get.put(DataController());

  AddHotel({Key? key}) : super(key: key);

  @override
  State<AddHotel> createState() => _AddHotelState();
}

class _AddHotelState extends State<AddHotel> {
  DataController controller = Get.find();
  var _userImageFile;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "p_name": "",
    "p_price": "",
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "phone_number": ""
  };

  void _pickedImage(File image) {
    _userImageFile = image;
    print('image incoming $_userImageFile');
  }

  addProduct() {
    if (_userImageFile == null) {
      Get.snackbar(
        "Opps",
        "Image Required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).errorColor,
        colorText: Colors.white,
      );
      return;
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for new hotel $productData');
      controller.addNewProduct(productData, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Product'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_location'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_price'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number  Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['phone_number'] = value!;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                ProductImagePicker(_pickedImage),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(addProduct());
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
