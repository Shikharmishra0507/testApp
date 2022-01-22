import '/Screens/HomeScreen.dart';

import 'package:flutter/material.dart';

class ConfirmScreen extends StatefulWidget {
  //const ConfirmScreen({Key? key}) : super(key: key);


  static String route='/ConfirmScreen';

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _controller=TextEditingController();
  bool _isEnabled=false;
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled=_controller.text.isNotEmpty;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  Future<void> verifyCode(BuildContext context,
      String _username,String _password,String code) async{

  }
  @override
  Widget build(BuildContext context) {
    final Map<String,String> args =
    ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    return isLoading ? CircularProgressIndicator():Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:AppBar(title:Text("Verification"),backgroundColor: Colors.blueGrey,),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical :20),
        
        child: Center(
          child: SafeArea(
            child: isLoading ? CircularProgressIndicator() :Column(
                children:[
                  Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
                    elevation:12,
                  child: Column(
              children:[
                  TextFormField(
                    controller: _controller,

                    decoration:InputDecoration(hintText:"Enter Verification Code",
                        prefixIcon: Icon(Icons.lock) )
                  ),
                SizedBox(height:10),
                ElevatedButton(

                    onPressed: !_isEnabled ? null  :  (){
                      verifyCode(context,args["Username"]!,args["Password"]!,_controller.text);
                    },
                    child:Text("Verify"),
                  )
              ]
            ),
                )]),
          ),
        ),
      )

    );
  }
}
