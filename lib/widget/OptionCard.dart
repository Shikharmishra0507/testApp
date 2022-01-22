import 'package:flutter/material.dart';

import '/Providers/Question.dart';
import '../models/SingleQuestion.dart';

enum AvailOptions { option1, option2, option3, option4, option5 }

class OptionCard extends StatefulWidget {
  final int _selectedIndex;

  @override
  OptionCard(this._selectedIndex);

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
//  int findSelectedOption(BuildContext context){
//    final questions=Question();
//    return questions.selectedOption(widget.questionId);
//  }

  AvailOptions getOption(int index) {
    if (index == 0) return AvailOptions.option1;
    if (index == 1) return AvailOptions.option2;
    if (index == 2) return AvailOptions.option3;
    if (index == 3) return AvailOptions.option4;
    return AvailOptions.option5;
  }

  int getIndex(AvailOptions option) {
    if (option == AvailOptions.option1) return 0;
    if (option == AvailOptions.option2) return 1;
    if (option == AvailOptions.option3) return 2;
    if (option == AvailOptions.option4) return 3;
    return 4;
  }

  Widget build(BuildContext context) {
    //final user=Provider.of<UserProvider>(context,listen:false);
    // AvailOptions getOption(String userId,String questionId){
    //   int index=UserProvider.getSelectedOption(widget._selectedIndex);
    //   AvailOptions option=AvailOptions.option5;
    //   switch(index){
    //     case 0:option=AvailOptions.option1;
    //     break;
    //     case 1:option=AvailOptions.option2;
    //     break;
    //     case 2:option=AvailOptions.option3;
    //     break;
    //     case 3:option=AvailOptions.option1;
    //     break;
    //     default:option=AvailOptions.option5;
    //     break;
    //   }
    //   return option;
    // }
    SingleQuestion quest = Question.questions[widget._selectedIndex];
    //final auth=Provider.of<Auth>(context,listen:false);
    // String userId=auth.getUserId!;
    AvailOptions? _selectedOption = quest.selectedOptionIndex == null
        ? AvailOptions.option5
        : getOption(quest.selectedOptionIndex!);
    return Container(
        //width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            ListTile(
                title: Text(quest.options[0].optionTitle),
                leading: Radio<AvailOptions>(
                    value: AvailOptions.option1,
                    groupValue: _selectedOption,
                    onChanged: (AvailOptions? opt) {
                      if (opt == null) return;
                      setState(() {
                        //user.getUser[userId]!.selectedOptions[widget.questionId]=0;
                        _selectedOption = opt;
                        if (_selectedOption != null){
                          quest.selectedOptionIndex =
                              getIndex(_selectedOption!);}
                      });
                    })),
            ListTile(
                title: Text(quest.options[1].optionTitle),
                leading: Radio<AvailOptions>(
                    value: AvailOptions.option2,
                    groupValue: _selectedOption,
                    onChanged: (AvailOptions? opt) {
                      if (opt == null) return;
                      setState(() {
                        //user.getUser[userId]!.selectedOptions[widget.questionId]=1;
                        _selectedOption = opt;
                        if (_selectedOption != null){
                          quest.selectedOptionIndex =
                              getIndex(_selectedOption!);}
                      });
                    })),
            ListTile(
                title: Text(quest.options[2].optionTitle),
                leading: Radio<AvailOptions>(
                    value: AvailOptions.option3,
                    groupValue: _selectedOption,
                    onChanged: (AvailOptions? opt) {
                      if (opt == null) return;
                      setState(() {
                        //user.getUser[userId]!.selectedOptions[widget.questionId]=2;
                        _selectedOption = opt;
                        if (_selectedOption != null){
                          quest.selectedOptionIndex =
                              getIndex(_selectedOption!);}
                      });
                    })),
            ListTile(
                title: Text(quest.options[3].optionTitle),
                leading: Radio<AvailOptions>(
                    value: AvailOptions.option4,
                    groupValue: _selectedOption,
                    onChanged: (AvailOptions? opt) {
                      if (opt == null) return;
                      setState(() {
                        //user.getUser[userId]!.selectedOptions[widget.questionId]=3;
                        _selectedOption = opt;
                        if (_selectedOption != null){
                          quest.selectedOptionIndex =
                              getIndex(_selectedOption!);}
                      });
                    })),
          ],
        ));
  }
}
