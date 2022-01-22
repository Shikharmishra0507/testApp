
import 'package:flutter/material.dart';
import 'package:test_app/Screens/HomeScreen.dart';
import 'package:test_app/Screens/InformationScreen.dart';
import 'package:test_app/Screens/TestScroll.dart';
import 'package:test_app/services/authentication.dart';
import 'package:test_app/widget/showError.dart';


enum AuthMode { Signup, Login }
class LoginCard extends StatefulWidget {

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }

  }




  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  var _isLoading = false;
  final _emailController=TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!

      return;
    }
    // if(_formKey.currentState!.save())
    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });
      try {
        if(_authMode==AuthMode.Login){
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        }
        else{
          await Authentication().signInAnon(_emailController.text,_contactController.text);
          Navigator.of(context).pushReplacementNamed(InformationScreen.route);
        }
      } on Exception catch (e) {
        // TODO
        ShowError().showErrorDialog(context, e.toString());
      }

      setState(() {
        _isLoading=false;
      });


  }

  Widget showSignUpDialog(){
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),  ),
          child: const Text('Close'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading==true ? CircularProgressIndicator() : Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child:  Container(
        height:_authMode==AuthMode.Signup ? deviceSize.height*0.7 :
        deviceSize.height*0.5,
        constraints:
        BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email',
                      prefixIcon:Icon(Icons.email) ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value==null)return 'Email cannot be Empty!!';
                    if (value.isEmpty || !value.contains("@") || !value.contains(".com")) {

                      return 'Invalid Email Address';
                    }
                    return null;
                  },
                  controller: _emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contact Number', prefixIcon: Icon(Icons.add_call)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value==null)return 'Number cannot be Empty!!';
                    if (value.isEmpty || value.length!=10) {

                      return 'Invalid Mobile Number';
                    }
                    return null;

                  },
                  controller: _contactController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if(value==null)return "Password cannot be Empty";
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                ),
                if(_authMode==AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                    } : null,
                  ),
                if(_authMode==AuthMode.Login)Container(
                  height: deviceSize.height*0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New to this app"),
                      TextButton(
                        child:Text("Sign up here"),
                        onPressed: (){
                          setState(() {
                            _authMode=AuthMode.Signup;
                          });
                        },
                      )
                    ],),
                ),
                if(_authMode==AuthMode.Signup) Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Text("Already Have an Account?")),
                      Flexible(
                        child: TextButton(
                          child:Text("Login here"),
                          onPressed: (){
                            setState(() {
                              _authMode=AuthMode.Login;
                            });
                          },
                        ),
                      )
                    ],),
                ),

                ElevatedButton(onPressed: submit, child:
                _authMode==AuthMode.Signup ? Text("Sign In") :  Text("Log In")),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
