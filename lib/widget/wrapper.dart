import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Screens/HomeScreen.dart';
import 'package:test_app/Screens/InformationScreen.dart';
import 'package:test_app/Screens/LoginScreen.dart';
import 'package:test_app/services/database.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var auth=Provider.of<User?>(context);
    String ?name;
    Database().basicInformationAvailable().then((value) {
      name=value;
    });
    return auth==null ? LoginScreen() :
    name==null ? InformationScreen() :HomeScreen();
  }
}
