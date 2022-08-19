import 'package:flutter/material.dart';
import 'package:flutter_fbfirestore_crud/pages/add_user_page.dart';
import 'package:flutter_fbfirestore_crud/pages/list_user_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

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
            Text('Admin Panel'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserPage(),
                  ),
                )
              },
              child: Text('Add', style: TextStyle(fontSize: 20.0)),
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            )
          ],
        ),
      ),
      body: ListUserPage(),
    );
  }
}
