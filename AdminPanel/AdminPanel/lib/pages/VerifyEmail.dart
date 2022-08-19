import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Timer? timer;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  @override
  void initState() {
    super.initState();
  }

  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  User? user = FirebaseAuth.instance.currentUser;

  redirect() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      Timer.periodic(
        Duration(seconds: 3),
        (_) => checkVerification(),
      );
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (!isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? redirect()
      : Scaffold(
          body: Container(
            child: Column(
              children: [
                SizedBox(height:100),
                Image.asset('assets/images/VerifyEmail.jpg'),
                SizedBox(height:100),
                Text('YOU ARE ONE STEP AWAY.',style:TextStyle(fontWeight:FontWeight.bold)),
                Text('Please click the verify button to verify your email.'),
                SizedBox(height:100),
                ElevatedButton(
                    onPressed: () => {verifyEmail()},
                    child: Text('Verify Email')
                    )
              ],
            ),
          ),
        );
}
