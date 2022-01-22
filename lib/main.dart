import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Screens/showMarks.dart';
import 'package:test_app/services/authentication.dart';
import 'package:test_app/services/database.dart';
import 'package:test_app/widget/wrapper.dart';

import '/Screens/ConfirmScreen.dart';

import '/Screens/TestScroll.dart';
import './Screens/AboutScreen.dart';


import '/Screens/LoginScreen.dart';
import '/Screens/InformationScreen.dart';
import '/Screens/HomeScreen.dart';

import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User?>.value(
      value:Authentication().isAuthenticated,
      initialData: null,

        child: MaterialApp(

              debugShowCheckedModeBanner: false,

              home:Wrapper(),
                  routes: {
                    ConfirmScreen.route:(_)=>ConfirmScreen(),
                    TestScroll.route:(_)=>TestScroll(),
                    HomeScreen.route:(_)=>HomeScreen(),
                    LoginScreen.route:(_)=>LoginScreen(),
                    InformationScreen.route:(_)=>InformationScreen(),
                    AboutScreen.route:(_)=>AboutScreen(),
                    ShowMarks.route:(_)=>ShowMarks(),
                  },
              ),

    );
  }
}
