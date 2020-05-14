import 'dart:convert';

import 'package:converter_provider/screens/myhome.dart';
import 'package:converter_provider/widgets/userdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<MyCustomForm> {
  
  final _formKey = GlobalKey<FormState>();
  UserInfo actualuser=null;
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
  @override
  Widget build(BuildContext context) {
    
    final screenState=Provider.of<Screen>(context,listen: true);
    String usr="";
    String pas="";
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'email',
                  labelText: 'email',
                ),
               
                validator: (value) {
                  if (value.isEmpty ) {
                    return 'Please enter some text';
                  }
                  usr=value;
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'pass',
                  labelText: 'Password',
                ),
                
                validator: (value) {
                  if (value.isEmpty ) {
                    return 'Please enter some text';
                  }
                  pas=value;
                  return null;
                },
                obscureText: true,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //print(usr);
                        //print(pas);
                        signIn(usr,  pas).then((val){
                          if (val){

                            _changeEmail(actualuser.email);
                            _changeName(actualuser.name);
                            _changeUsername(actualuser.username);
                            _changeToken(actualuser.token);
                            _changePassword(pas);
                            screenState.changeUser(actualuser);
                            screenState.change_state();
                            
                            screenState.initList().then((cl){
                              print(cl);
                              screenState.startList();
                              screenState.changeCourses(cl);
                              screenState.change_state();
                              _changeState();
                            });
                          }
                          else{
                            print("validate false pass wrong");
                            showAlertDialog(context);
                          }
                        }).catchError((error){
                          print(error);
                          print("validate false error sign in");
                          showAlertDialog(context);});                                           
                      }
                    },
                    child: Text("Sign in",
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ))),
              ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      
                        //print(usr);
                        //print(pas);
                        getSharedUser().then((us){
                          getSharedPass().then((pa){
                            signIn(us,  pa).then((val){
                          if (val){
                            _changeEmail(actualuser.email);
                            _changeName(actualuser.name);
                            _changeUsername(actualuser.username);
                            _changeToken(actualuser.token);
                            _changePassword(pa);
                            screenState.changeUser(actualuser);
                            
                            screenState.initList().then((cl){
                              screenState.changeCourses(cl);
                              screenState.change_state();
                              _changeState();
                            });
                            
                          }
                          else{
                            print("validate false pass wrong");
                            showAlertDialog(context);
                          }
                        }).catchError((error){
                          print(error);
                          print("validate false error sign in");
                          showAlertDialog(context);});    
                          });
                        });
                                                               
                      },
                    
                    child: Text("Remember user",
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ))),
              ),
        ]
     )
    );
  }
  
  Future<bool> signIn(String email, String password) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,'password': password
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      UserInfo ui=UserInfo.fromJson(json.decode(response.body));
      actualuser=ui;
      return true;
      
    } else {
      print("signin failed");
      print('${response.body}');
      showAlertDialog(context);
     //throw Exception(response.body);
     }
    
  }
  Future<String> getSharedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usr = prefs.getString('email');
    return usr;
  }
  Future<String> getSharedPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usr = prefs.getString('password');
    return usr;
  }
  _changeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('screen', false);
  }
  _changeUsername(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = s;
    await prefs.setString('username', user);
  }
  _changeToken(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = s;
    await prefs.setString('token', token);
  }
  _changeEmail(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = s;
    await prefs.setString('email', email);
  }
  _changeName(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = s;
    await prefs.setString('name', name);
  }
  _changePassword(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = s;
    await prefs.setString('password', pass);
  }
}
class MyCustomForm2 extends StatefulWidget {
  @override
  MyCustomFormState2 createState() {
    return MyCustomFormState2();
  }
}


class MyCustomFormState2 extends State<MyCustomForm2> {
  
  final _formKey = GlobalKey<FormState>();
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
      content: Text("Enter all the info"),
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
  @override
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    String usr="";
    String email="";
    String pass="";
    String name="";
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Username',
                  labelText: 'Username',
                ),
                
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  usr=value;
                  /*screenState.change_username(value);*/
                  _changeUsername(value);
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'pass',
                  labelText: 'Password',
                ),
                
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  pass=value;
                  /*screenState.change_password(value);*/
                  _changePassword(value);
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'email',
                  labelText: 'Email',
                ),
                
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  email=value;
                  /*screenState.change_email(value);*/
                  _changeEmail(value);
                  return null;
                },
                
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.people),
                  hintText: 'name',
                  labelText: 'Name',
                ),
                
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }

                  name=value;
                  _changeName(value);
                  return null;
                },
                
              ),
              RaisedButton(
                onPressed: () {
                  
                  if (_formKey.currentState.validate()) {
                    signUp(email,pass,usr,name).then((user) {
                      screenState.changeUser(user);
                    }).catchError((error){showAlertDialog(context);});   
                    
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
        ]
     )
    );
  }
  Future<UserInfo> signUp(String email, String password, String username, String name) async {

    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,'password': password,'username': username,'name': name
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      return UserInfo.fromJson(json.decode(response.body));
    } else {
      print("signup failed");
      print('${response.body}');
      showAlertDialog(context);
     }
    
  }
  
   

  _changeUsername(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = s;
    await prefs.setString('username', user);
  }
  
  _changeEmail(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = s;
    await prefs.setString('email', email);
  }
  _changeName(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = s;
    await prefs.setString('name', name);
  }
  _changePassword(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = s;
    await prefs.setString('password', pass);
  }
}