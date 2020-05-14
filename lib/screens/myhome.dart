import 'dart:convert';

import 'package:converter_provider/widgets/converter.dart';
import 'package:converter_provider/widgets/userdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class Screen with ChangeNotifier{
  

  bool  get screen =>_logged;
  bool _logged=true;
  String _username="";
  String _name="";
  String _email="";
  String _token="";
  UserInfo  ui ;
  List<String> coursesList; 

  void init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _logged=prefs.getBool('screen')??true;
    ui =UserInfo(token: prefs.getString('token')??"",username: prefs.getString('username')??"",name: prefs.getString('name')??"",email: prefs.getString('email')??"");
    changeUsername(ui.username);
    changeEmail(ui.email);
    changeName(ui.name);
    changeToken(ui.token);
    notifyListeners();
  }
  get courses =>coursesList;
  
  Future<List<String>> initList() async{
    Uri uri2 = Uri.https("movil-api.herokuapp.com", 'check/token', {
      'token':"${ui.token}"
    });

    final http.Response response2 = await http.post(
      uri2,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
    Validation val = Validation.fromJson(jsonDecode(response2.body));
    if(val.valid){
      List<String> cl = new List<String> ();
      //print(ui.token);
      Uri uri = Uri.https("movil-api.herokuapp.com", '$username/courses', {
        'token':"${ui.token}"
      });

      final http.Response response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
      );
      
      //print('${response.body}');
      //print('${response.statusCode}');

      
      
      //print('${response2.body}');
      //print('${response2.statusCode}');

      //print(''+_username);
      //print(jsonDecode(response.body));
      List l=jsonDecode(response.body);
      //print(l.length);
      for (var i = 0; i < l.length; i++) {
        Course c =Course.fromJson(l[i]);
        cl.add(c.toString());
      }
      return cl;
    }else return new List<String>();
    
    //print(coursesList);
  }
  void changeCourses(List<String> l){
    
    coursesList=l;
  }
  Future<List<String>> addCourse() async {
    //print(ui.token);
    //print(ui.prn());
    Uri uri = Uri.https("movil-api.herokuapp.com", '$username/courses', {
      'token':"${ui.token}"
    });

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
    
    //print('${response.body}');
    //print('${response.statusCode}');
    //print(''+_username);
    return initList();
  }

  Future<bool> validateToken() async{
    Uri uri2 = Uri.https("movil-api.herokuapp.com", 'check/token', {
      'token':"${ui.token}"
    });

    final http.Response response2 = await http.post(
      uri2,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
    Validation val = Validation.fromJson(jsonDecode(response2.body));
    return val.valid;
  }

  Future<bool> restartDB() async{
    Uri uri2 = Uri.https("movil-api.herokuapp.com", '$username/restart', {
      'token':"${ui.token}"
    });

    final http.Response response = await http.get(
      uri2,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
    print(json.decode(response.body));
    return true;
    
  }
  void change_state(){
    _logged=!_logged;
    notifyListeners();
  }
  void startList(){
    coursesList=new List<String>();
  }
  void changeUsername(String s){
    
    _username=s;
    notifyListeners();
  }
  get username => _username;
  void changeName(String s){
    
    _name=s;
    notifyListeners();
  }
  get name => _name;
  void changeEmail(String s){
    
    _email=s;
    notifyListeners();
  }
  get email => _email;

  void changeToken(String s){
    
    _token=s;
    notifyListeners();
  }
  get token => _token;
  void changeUser(UserInfo s){
    
    ui=s;
    print(s.prn());
    changeUsername(s.username);
    changeEmail(s.email);
    changeName(s.name);
    changeToken(s.token);
    print(_email+" "+_username+" "+_name);
    notifyListeners();
  }
  get userinfo => ui;
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Screen>( 
      create: (context) => Screen(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login demo',
        theme: ThemeData(
           primaryColor: Colors.green,
           accentColor: Colors.greenAccent,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Login demo'),
            ),
            body: Center(child: Converter()))
      )
    );
  }
}
