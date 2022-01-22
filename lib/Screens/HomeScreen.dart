import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_app/services/authentication.dart';
import 'package:test_app/services/database.dart';

import 'AboutScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  static const String route="/homeScreen";


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }

  }

  @override
  
  int _selectedIndex = 0;



  void navigationBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text("My Chat App"),
            backgroundColor: Colors.pink,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AboutScreen.route);
                },
                icon: Icon(Icons.info),),
              IconButton(
                onPressed: () async{
                  await Authentication().signOut();

                },
                icon: Icon(Icons.logout),)
            ]
        ),
        body: Container(
            child:  Text("hello World")
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: 'contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings'),
          ],
          onTap: navigationBarTap,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black26,
        )


    );
  }
}
