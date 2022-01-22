import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/Screens/HomeScreen.dart';
import 'package:test_app/widget/showError.dart';
import '../services/database.dart';
import '../Screens/TestScroll.dart';
class InformationCard extends StatefulWidget {
  const InformationCard({Key? key}) : super(key: key);

  @override
  State<InformationCard> createState() => _InformationCardState();
}
enum Gender { Male, Female, Other,NotSelected }
class _InformationCardState extends State<InformationCard> {

  TextEditingController _nameController=new TextEditingController();
  TextEditingController _ageController=new TextEditingController();
  TextEditingController _descriptionController=new TextEditingController();
  Gender _selectedGender=Gender.NotSelected;
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();

    _descriptionController.dispose();
    super.dispose();
  }
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  int dobToAge(String birthDateString) {
    String datePattern = 'dd-MM-yyyy';

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //String userId = ModalRoute.of(context)!.settings.arguments as String;
    final _formKey = GlobalKey<FormState>();


    bool isLoading = false;
    void saveForm() async {

      if (!_formKey.currentState!.validate() ) return;
      if(_selectedGender==Gender.NotSelected){
          ShowError().showErrorDialog(context, "Please Select your gender");

        return ;
      }
      String g=_selectedGender==Gender.Male?"Male" :_selectedGender==Gender.Female ? "Female" :"Other";
      setState(() {
        isLoading = true;
      });
      try{
        await Database().userPersonalDataUpload(_nameController.text,
            g, selectedDate);
        Navigator.of(context).pushReplacementNamed(TestScroll.route);
      }
      catch(e){
        ShowError().showErrorDialog(context, e.toString());
      }
      setState(() {
        isLoading = false;
      });

    }

    return  isLoading == true
        ? CircularProgressIndicator()
        :Center(
      child: Container(
        alignment: Alignment.center,
        width: size.width*0.7,
        height: size.height*0.7,
        color: Color.fromRGBO(255, 255, 255, 0.8),
        child:
        SingleChildScrollView(
          child: Column(
              children: [
            Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter Your Full Name"),
                  validator: (value) {
                    if (value == null ) return "Not a Valid Name";
                    return null;
                  },
                  controller: _nameController,
                ),
                SizedBox(
                  height: size.height*0.05,
                  width:size.width*0.05,
                ),
                ElevatedButton(onPressed: (){
                  _selectDate(context);}, child: Text("Select Your DOB")),

                SizedBox(
                  height: size.height*0.05,
                  width:size.width*0.05,
                ),
                Container(
                  width: size.width*0.5,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(child: Text("Gender",style:TextStyle(
                          fontSize: 18))),
                      ListTile(
                        leading: Radio<Gender>(
                          value: Gender.Male,
                          groupValue: _selectedGender,
                          onChanged: (Gender? gender) {
                            setState(() {
                              _selectedGender = gender!;
                            });
                          },
                        ),
                        title: Text("Male"),
                      ),
                      ListTile(
                          leading: Radio<Gender>(
                            value: Gender.Female,
                            groupValue: _selectedGender,
                            onChanged: (Gender? gender) {
                              setState(() {
                                _selectedGender = gender!;
                              });
                            },

                          ),
                          title: Text("Female")),

                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.05,
                  width:size.width*0.05,
                ),
                SizedBox(
                  height: size.height*0.05,
                  width:size.width*0.05,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: saveForm,
                      child: Text("Submit")),
                )
              ],
            ),
          )
              ],


      ),
        ),
      )
    );
  }
}
