import '../concept/pair.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/concept/classifier.dart';
class Database{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _user = FirebaseAuth.instance;

  Future<String?> basicInformationAvailable() async{
    if(_user.currentUser==null)return null;
    DocumentSnapshot snapshot=await
     firestore.collection("user").doc(_user.currentUser!.uid).get();
    Map<String,dynamic>? data=snapshot.data() as Map<String,dynamic>?;
    if(data==null || data['name']==null)return null;
    return data['Name'];
  }


  Future<void> userTestMarksDataUpload(
      int a_marks,
      int b_marks,
      int c_marks,
      int total_marks,

      List<int> a_test_ans,
      ) async{

    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot=await firestore.collection("user").doc(firebaseUser!.uid)
        .get();
    Map<String,dynamic> data=snapshot.data() as Map<String,dynamic>;
    if(data['Gender']=="Male"){
      total_marks-=a_marks;
      a_marks=54-a_marks;
      total_marks+=a_marks;
    }
    String userGroup=Classifier().classGroup(a_marks+b_marks+c_marks, a_marks,b_marks,
        c_marks);
    try {
      await firestore.collection("user").doc(firebaseUser.uid).set({
        'UID':data["UID"],
        'email':data['email'],
        'phoneNo':data['phoneNo'],
        'Name':data['Name'],
        'DOB':data['DOB'],
        'Gender':data['Gender'],
        'a_test_marks': a_marks,
        'b_test_marks': b_marks,
        'c_test_marks': c_marks,
        'total_test_marks': total_marks,
        'a_test_ans': a_test_ans,
        'user_group': userGroup
      });
    } on Exception catch (e) {
      // TODO
      rethrow;
    }
  }

// fun to upload user personal data to databse
  Future<void> userPersonalDataUpload (
      String name, String gender,DateTime dob) async{

    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot=await firestore.collection("user").doc(firebaseUser!.uid).get();
    Map<String,dynamic> data=snapshot.data() as Map<String,dynamic>;
    try {
      await firestore.collection("user").doc(firebaseUser.uid).set({
        'UID': firebaseUser.uid,
        'Name': name,
        'Gender': gender,
        'DOB':dob.toString(),
        'email':data['email'],
        'phoneNo':data['phoneNo']
      });
    } on Exception catch (e) {
      // TODO
      rethrow;
    }
  }
  Future<void>userEmailAndContact(String email,String phoneNo) async{
    var firebaseUser = FirebaseAuth.instance.currentUser;
    try{
      await firestore.collection("user").doc(firebaseUser!.uid).set({
        'UID': firebaseUser.uid,
        'email':email,
        'phoneNo':phoneNo
      });
    }
    on Exception catch(e){
      rethrow;
    }


  }

}