import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_hotel_booking_ui/modules/hotel_booking/fireBaseAddStore/model/product_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'comman_dailog.dart';

class DataController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;

  List<Product> allProduct = [];

  void onReady() {
    super.onReady();
    getAllProduct();
  }

  Future<void> addNewProduct(Map productdata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
        FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();

    try {
      // CommanDialog.showLoading();
      var response = await firebaseInstance.collection('productlist').add({
        'product_name': productdata['p_name'],
        'product_price': productdata['p_price'],
        "product_upload_date": productdata['p_upload_date'],
        'product_image': imageUrl,
        'product_location': productdata['p_location'],
        // 'user_Id': authController.userId,
        "phone_number": productdata['phone_number'],
      });
      print("Firebase response1111 $response");
      // CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      // CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }

  // Future<void> addNewProduct(Map productdata, File image) async {
  //   Get.put(DataController());
  //   var pathimage = image.toString();
  //   var temp = pathimage.lastIndexOf('/');
  //   var result = pathimage.substring(temp + 1);
  //   print(result);
  //   final ref =
  //       FirebaseStorage.instance.ref().child('product_images').child(result);
  //   var response = await ref.putFile(image);
  //   print("Updated $response");
  //   var imageUrl = await ref.getDownloadURL();

  //   try {
  //     // Comm.showLoading();
  //     var response = await firebaseInstance.collection('productlist').add({
  //       'Hotel_name': productdata['p_name'],
  //       'Hotel_price': productdata['p_price'],
  //       "Hotel_location": productdata['p_location'],
  //       'product_image': imageUrl,
  //       // 'user_Id': authController.userId,
  //     });
  //     print("Firebase response1111 $response");
  //     // CommanDialog.hideLoading();
  //     Get.back();
  //   } catch (exception) {
  //     // CommanDialog.hideLoading();
  //     print("Error Saving Data at firestore $exception");
  //   }
  // }
  Future<void> getAllProduct() async {
    allProduct = [];
    try {
      // CommanDialog.showLoading();
      final List<Product> lodadedProduct1 = [];
      var response = await firebaseInstance.collection('productlist').get();
      print(response);
      //  .where('user_Id', isNotEqualTo: authController.userId).get();
      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          print(result.data());
          print(result.id);
          lodadedProduct1.add(
            Product(
                productId: result.id,
                // userId: result['user_Id'],
                productname: result['product_name'],
                productprice: double.parse(result['product_price']),
                productimage: result['product_image'],
                productlocation: result['product_location'],
                // phonenumber: int.parse(result['phone_number']),
                productuploaddate: result['product_upload_date'].toString()),
          );
          // productId: result.id,
          // // userId: result['user_Id'],
          // productname: result['product_name'],
          // productprice: double.parse(result['product_price']),
          // productimage: result['product_image'],
          // hotellocation: result['product_location'],
          // productuploaddate: result['product_upload_date'].toString()),
        }
        allProduct.addAll(lodadedProduct1);
        update();
      }

      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }
  // Future<void> getAllProduct() async {
  //   allProduct = [];
  //   try {
  //     // CommanDialog.showLoading();
  //     final List<Product> lodadedProduct1 = [];
  //     var response = await firebaseInstance.collection('productlist').get();
  //     print(response);
  //     //  .where('user_Id', isNotEqualTo: authController.userId).get();
  //     if (response.docs.isNotEmpty) {
  //       for (var result in response.docs) {
  //         print(result.data());
  //         print(result.id);
  //         lodadedProduct1.add(
  //           Product(
  //               productId: result.id,
  //               // userId: result['user_Id'],
  //               productname: result['product_name'],
  //               productprice: double.parse(result['product_price']),
  //               productimage: result['product_image'],
  //               productlocation: result['product_location'],
  //               phonenumber: int.parse(result['phone_number']),
  //               productuploaddate: result['product_upload_date'].toString()),
  //         );
  //         // productId: result.id,
  //         // // userId: result['user_Id'],
  //         // productname: result['product_name'],
  //         // productprice: double.parse(result['product_price']),
  //         // productimage: result['product_image'],
  //         // hotellocation: result['product_location'],
  //         // productuploaddate: result['product_upload_date'].toString()),
  //       }
  //       allProduct.addAll(lodadedProduct1);
  //       update();
  //     }

  //     // CommanDialog.hideLoading();
  //   } on FirebaseException catch (e) {
  //     // CommanDialog.hideLoading();
  //     print("Error $e");
  //   } catch (error) {
  //     // CommanDialog.hideLoading();
  //     print("error $error");
  //   }
  // }
}
