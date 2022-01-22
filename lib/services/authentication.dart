import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/services/database.dart';
class Authentication {
  FirebaseAuth auth=FirebaseAuth.instance;
  Stream<User?> get isAuthenticated{
    print('inside isAuthentcated');
    return  FirebaseAuth.instance.authStateChanges();
  }
  Future<void> signInAnon(String email,String phoneNo) async{
    try {
      await auth.signInAnonymously();
      await Database().userEmailAndContact(email, phoneNo);
    } on Exception catch (e) {
      // TODO
    }

  }
  Future<void> signOut() async {
    print("here");
    try {
       await auth.signOut();

    } on Exception catch (e) {
      // TODO
      print(e);
    }

  }
}