import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AboutScreen extends StatelessWidget {
  static const String route='/AboutScreen';
  @override

  Widget build(BuildContext context) {
    return Scaffold( appBar:AppBar(
      elevation: 10,
      centerTitle:true,
      title: Text("Profile"),
      leading: IconButton(icon:Icon(Icons.arrow_back),onPressed: (){},),
    ),
    body:Container(
      child:Stack(
        children:[




          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children:[
              ListTile(leading: Icon(Icons.verified_user),title:Text("Your Name") ),
              ListTile(title: Text("Your Age"),),
              ListTile(title:Text("Your About"))
          ]),]

      ),
    ));
  }
}
