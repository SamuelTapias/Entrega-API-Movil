

import 'package:converter_provider/screens/myhome.dart';
import 'package:converter_provider/widgets/form.dart';
import 'package:converter_provider/widgets/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  @override
  Widget showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ERROR"),
      content: Text("Enter username and password"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            MyCustomForm(),
            
            Container(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                    
                  },
                  child: Text("Sign up",
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ))),
            ),
            
          ]),
          
    );

  }

  
}