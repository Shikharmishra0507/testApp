import 'package:flutter/material.dart';
import 'package:test_app/Screens/HomeScreen.dart';
import 'InformationScreen.dart';
class ShowMarks extends StatelessWidget {
  const ShowMarks({Key? key}) : super(key: key);
  static const String route='/ShowMarks';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<int>?;

    return Scaffold(
      body: args ==null?Column(children: [
        Text("Error"),
        ElevatedButton(child: Text("Go to Front Page"), onPressed:(){
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        })
      ],) : Column(
        children: [
          Text("Marks 1=${args[0]}"),
          Text("Marks2 = ${args[1]}"),
          Text("Marks3  = ${args[2]}"),
          Text("Total Marks = ${args[2]+args[1]+args[0]}"),
          TextButton(onPressed: ()=>Navigator.of(context).
          pushReplacementNamed(HomeScreen.route),
        child: Text("Go To Home"))
        ],
      ),
    );
  }
}
