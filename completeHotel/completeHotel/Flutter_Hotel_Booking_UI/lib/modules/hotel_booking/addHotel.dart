// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import '';

// class MyHomePage extends StatefulWidget {
//   static const String routeName = '/addHotel';
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File? image;

//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (image == null) return;

//       final imageTemp = File(image.path);

//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   Future pickImageC() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);

//       if (image == null) return;

//       final imageTemp = File(image.path);

//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Image Picker Example"),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Gallery",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     pickImage();
//                   }),
//               SizedBox(
//                 height: 20,
//               ),
//               image != null ? Image.file(image!) : Text("No image selected")
//             ],
//           ),
//         ));
//   }
// }










































// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart' as path;

// class AddImage extends StatefulWidget {
//   @override
//   _AddImageState createState() => _AddImageState();
// }

// class _AddImageState extends State<AddImage> {
//   bool uploading = false;
//   double val = 0;
//   late CollectionReference imgRef;
//   late firebase_storage.Reference ref;

//   List<File> _image = [];
//   final picker = ImagePicker();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Add Image'),
//           actions: [
//             FlatButton(
//                 onPressed: () {
//                   setState(() {
//                     uploading = true;
//                   });
//                   uploadFile().whenComplete(() => Navigator.of(context).pop());
//                 },
//                 child: Text(
//                   'upload',
//                   style: TextStyle(color: Colors.white),
//                 ))
//           ],
//         ),
//         body: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.all(4),
//               child: GridView.builder(
//                   itemCount: _image.length + 1,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3),
//                   itemBuilder: (context, index) {
//                     return index == 0
//                         ? Center(
//                             child: IconButton(
//                                 icon: Icon(Icons.add),
//                                 onPressed: () =>
//                                     !uploading ? chooseImage() : null),
//                           )
//                         : Container(
//                             margin: EdgeInsets.all(3),
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: FileImage(_image[index - 1]),
//                                     fit: BoxFit.cover)),
//                           );
//                   }),
//             ),
//             uploading
//                 ? Center(
//                     child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         child: Text(
//                           'uploading...',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       CircularProgressIndicator(
//                         value: val,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                       )
//                     ],
//                   ))
//                 : Container(),
//           ],
//         ));
//   }

//   chooseImage() async {
//     final pickedFile = await FilePicker.platform.pickFiles();
//     setState(() {
//       final path = pickedFile?.files.single.path;
//     });
//     if (pickedFile == null) retrieveLostData();
//   }

//   Future<void> retrieveLostData() async {
//     final LostData response = await picker.getLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {});
//     } else {
//       print(response.file);
//     }
//   }

//   Future uploadFile() async {
//     int i = 1;

//     for (var img in _image) {
//       setState(() {
//         val = i / _image.length;
//       });
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('images/${Path.basename(img.path)}');
//       await ref.putFile(img).whenComplete(() async {
//         await ref.getDownloadURL().then((value) {
//           imgRef.add({'url': value});
//           i++;
//         });
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     imgRef = FirebaseFirestore.instance.collection('imageURLs');
//   }
// }
