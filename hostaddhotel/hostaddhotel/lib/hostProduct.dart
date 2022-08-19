import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart/data_controller.dart';

class HostEdit extends StatefulWidget {
  @override
  _HostEditState createState() => _HostEditState();
}

class _HostEditState extends State<HostEdit> {
  final DataController controller = Get.find();

  final editPriceValue = TextEditingController();
  final editHotelName = TextEditingController();
  final editHotelLocation = TextEditingController();

  editProduct(productID, produtPrice, productLocation, productName) {
    editPriceValue.text = produtPrice.toString();
    editHotelLocation.text = productLocation.toString();
    editHotelName.text = productName.toString();
    Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 450,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Enter new price"),
                  controller: editPriceValue,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Enter new Hotel Name"),
                  controller: editHotelName,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Enter new Hotel location"),
                  controller: editHotelLocation,
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.editProduct(productID, editPriceValue.text,
                        editHotelLocation.text, editHotelName.text);
                        setState(() {
                          
                        });
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getLoginUserProduct();
    });

    return Scaffold(
      appBar: AppBar(title: Text('Manage Hotel')),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.allProduct.isEmpty
            ? Center(
                child: Text(' no added hotel found'),
              )
            : ListView.builder(
                itemCount: controller.allProduct.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            controller.allProduct[index].productimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Product Name: ${controller.allProduct[index].productname}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Price: ${controller.allProduct[index].productprice.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  editProduct(
                                      controller.allProduct[index].productId,
                                      controller.allProduct[index].productprice,
                                      controller
                                          .allProduct[index].productlocation,
                                      controller.allProduct[index].productname);

                                  // editProduct(
                                  //   controller.loginUserData[index].productId,
                                  //   controller
                                  //       .loginUserData[index].productprice,
                                  // );
                                },
                                child: Text('Edit'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                        controller.deleteProduct(
                                      controller.allProduct[index].productId);
                                      });
                                  
                                      
                                },
                                child: Text('Delete'),
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
}
