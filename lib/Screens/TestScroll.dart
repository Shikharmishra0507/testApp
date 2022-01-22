import 'package:flutter/material.dart';
import 'package:test_app/Screens/showMarks.dart';

import 'package:test_app/services/authentication.dart';
import 'package:test_app/services/database.dart';
import 'package:test_app/widget/showError.dart';
import '../Providers/Question.dart';
import '../widget/OptionCard.dart';
class TestScroll extends StatefulWidget {

  static  String route="/TestScroll";
  @override
  _TestScrollState createState() => _TestScrollState();
}

class _TestScrollState extends State<TestScroll> {

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }

  }

  final questions =
      Question.testQuestions;
  int marks1=0,marks2=0,marks3=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to your Test!"),actions:[
        IconButton(
          onPressed: () async {
            await Authentication().signOut();
          },
          icon: Icon(Icons.logout),
        ),
        ElevatedButton(onPressed:() async{
          int questionNo=0;
          List<int>a=new List.filled(29,-1);
          bool unAttempted=false;
          questions.forEach((quest) {


            if(quest.selectedOptionIndex==null){
              unAttempted=true;
              return ;
            }

            if(questionNo<9){
              marks1+=quest.options[quest.selectedOptionIndex!].marks;
              a[questionNo]=quest.selectedOptionIndex!+1;
            }
            else if(questionNo<18){
              marks2+=quest.options[quest.selectedOptionIndex!].marks;
              a[questionNo]=quest.selectedOptionIndex!+1;
            }
            else{
              marks3+=quest.options[quest.selectedOptionIndex!].marks;
              a[questionNo]=quest.selectedOptionIndex!+1;
            }
            questionNo+=1;
          });
          if(unAttempted){
              ShowError().showErrorDialog(context, "Please Attempt all Questions");
              return ;
          }


          await Database().userTestMarksDataUpload(marks1,marks2, marks3,
              marks2+marks1+marks3, a);

          Navigator.of(context).pushReplacementNamed(ShowMarks.route,
              arguments: [marks1,marks2,marks3]);
        },child:Text("Finished!"))
      ]),
      body:Container(
        decoration:BoxDecoration(color: Color.fromRGBO(205, 99, 247, 1)),
        child: Scrollbar(
          child: ListView.builder(

            itemCount: Question.questions.length,
              itemBuilder: (context,index){
            return Card(
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("${index+1} "+
                      questions[index].question,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  OptionCard(index),
                ],
              ),
            );
          }),
        ),
      )
    );
  }
}
