import 'dart:convert';
import 'dart:math';
import 'package:converter_provider/screens/myhome.dart';
import 'package:converter_provider/widgets/userdata.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FutureBuilderCourse extends StatefulWidget {
  @override
  _FutureBuilderCourseState createState() => _FutureBuilderCourseState();
}

class _FutureBuilderCourseState extends State<FutureBuilderCourse> {

  Future<InCourse> myFuture;
  
  @override
  initState(){
    
    myFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text("Curso"),
        ),
        body:FutureBuilder(
          future: myFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) { 
                  return Center(child: Text('ERROR -> ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.name ,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              
                              Container(
                                      height: 50,
                                      margin: EdgeInsets.all(2),
                                      color: Colors.orange,
                                      child: Center(
                                        child: MaterialButton(child: Text('Professor: ${snapshot.data.professor.toString()}',
                                          style: TextStyle(fontSize: 15)),
                                          onPressed:(){
                                            screenState.validateToken().then((vali){
                                              if(vali){
                                                _changeProfessor(snapshot.data.professor.toString().split(" ")[0]).then((val){
                                                  print(snapshot.data.professor.toString().split(" ")[0]);
                                                   Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => FutureBuilderProfessor()),
                                                ) ;
                                                });
                                              }else showAlertDialog(context);
                                            });
                                            
                                            
                                          }
                                        ),
                                        
                                      ),
                                    ),
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data.students.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      height: 50,
                                      margin: EdgeInsets.all(2),
                                      color: Colors.green,
                                      child: Center(
                                        child: MaterialButton(child: Text('${snapshot.data.students[index]}',
                                          style: TextStyle(fontSize: 15)),
                                          onPressed:(){
                                            screenState.validateToken().then((vali){
                                              if(vali){
                                                _changeStudent(snapshot.data.students[index].toString().split(" ")[0]).then((val){
                                                  print(snapshot.data.students[index].toString().split(" ")[0]);
                                                  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => FutureBuilderStudent()),
                                                  );
                                                });
                                              }else showAlertDialog(context);
                                            });
                                          }
                                        ),
                                        
                                      ),
                                    );
                                        }
                                      )),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                                heroTag: 'b3',
                                onPressed: () {
                                  screenState.validateToken().then((vali){
                                    if(vali){
                                      createStudent();
                                      showAlertDialog(context);
                                    }else showAlertDialog(context);
                                  });
                                },
                                child: Icon(Icons.add),
                                backgroundColor: Colors.green,)),
                                      
                                      
                                    ]),
                                  
                              );
                } else {
                   return Center(child: new CircularProgressIndicator());
                }
            })
    );
  }
}

class FutureBuilderStudent extends StatefulWidget {
  @override
  _FutureBuilderStudentState createState() => _FutureBuilderStudentState();
}

class _FutureBuilderStudentState extends State<FutureBuilderStudent> {

  Future<Student> myFuture;
  
  @override
  initState(){
    
    myFuture = getStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Curso"),
        ),
        body:FutureBuilder(
          future: myFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) { 
                  return Center(child: Text('ERROR -> ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.name ,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.username,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.phone,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.email,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.city,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),   
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.country,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),    
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.birthday,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              ]),
                            );
                } else {
                   return Center(child: new CircularProgressIndicator());
                }
            })
    );
  }
}

class FutureBuilderProfessor extends StatefulWidget {
  @override
  _FutureBuilderProfessorState createState() => _FutureBuilderProfessorState();
}

class _FutureBuilderProfessorState extends State<FutureBuilderProfessor> {

  Future<Student> myFuture;
  
  @override
  initState(){
    
    myFuture = getProfessor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Curso"),
        ),
        body:FutureBuilder(
          future: myFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) { 
                  return Center(child: Text('ERROR -> ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.name ,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.username,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.phone,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.email,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.city,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),   
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.country,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),    
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data.birthday,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.green,
                                        fontSize: 20),
                                  )),
                              ]),
                            );
                } else {
                   return Center(child: new CircularProgressIndicator());
                }
            })
    );
  }
}

class FutureBuilderAllStudents extends StatefulWidget {
  @override
  _FutureBuilderAllStudentsState createState() => _FutureBuilderAllStudentsState();
}

class _FutureBuilderAllStudentsState extends State<FutureBuilderAllStudents> {  

  Future<AllStudents> myFuture;
  
  @override
  initState(){
    
    myFuture = getDataStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text("Students"),
        ),
        body:FutureBuilder(
          future: myFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) { 
                  return Center(child: Text('ERROR -> ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              
                              
                              
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data.students.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      height: 50,
                                      margin: EdgeInsets.all(2),
                                      color: Colors.green,
                                      child: Center(
                                        child: MaterialButton(child: Text('${snapshot.data.students[index]}',
                                          style: TextStyle(fontSize: 15)),
                                          onPressed:(){
                                            
                                            screenState.validateToken().then((vali){
                                              if(vali){
                                                _changeStudent(snapshot.data.students[index].toString().split(" ")[0]).then((val){
                                                  print(snapshot.data.students[index].toString().split(" ")[0]);
                                                  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => FutureBuilderStudent()),
                                                  );
                                                });
                                              }
                                              else showAlertDialog(context);
                                            });
                                            
                                          }
                                        ),
                                        
                                      ),
                                    );
                                        }
                                      )),
                                      
                                      
                                    ]),
                              );
                } else {
                   return Center(child: new CircularProgressIndicator());
                }
            })
    );
  }
}

class FutureBuilderAllProfessors extends StatefulWidget {
  @override
  _FutureBuilderAllProfessorsState createState() => _FutureBuilderAllProfessorsState();
}

class _FutureBuilderAllProfessorsState extends State<FutureBuilderAllProfessors> {  

  Future<AllStudents> myFuture;
  
  @override
  initState(){
    
    myFuture = getDataProfessors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text("Professors"),
        ),
        body:FutureBuilder(
          future: myFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) { 
                  return Center(child: Text('ERROR -> ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              
                              
                              
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data.students.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      height: 50,
                                      margin: EdgeInsets.all(2),
                                      color: Colors.green,
                                      child: Center(
                                        child: MaterialButton(child: Text('${snapshot.data.students[index]}',
                                          style: TextStyle(fontSize: 15)),
                                          onPressed:(){
                                            screenState.validateToken().then((vali){
                                              if(vali){
                                                _changeProfessor(snapshot.data.students[index].toString().split(" ")[0]).then((val){
                                                  print(snapshot.data.students[index].toString().split(" ")[0]);
                                                  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => FutureBuilderProfessor()),
                                                  );
                                                });
                                              }
                                              else showAlertDialog(context);
                                            });
                                            
                                            
                                          }
                                        ),
                                        
                                      ),
                                    );
                                        }
                                      )),
                                      
                                      
                                    ]),
                              );
                } else {
                   return Center(child: new CircularProgressIndicator());
                }
            })
    );
  }
}

Future<bool> _changeStudent(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idstudent', s);
}

Future<bool> _changeProfessor(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idprofessor', s);
}

Future<AllStudents> getDataProfessors() async { //  <--- async function
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString('token');
  String username=prefs.getString('username');
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/professors', {
      'token':"$token"
    });

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
    print(json.decode(response.body));
  List<dynamic> re=json.decode(response.body);
  AllStudents ic =AllStudents.fromJson(re);
  await Future.delayed(Duration(seconds: 3));
  return Future.value(ic);
}

Future<InCourse> getData() async { //  <--- async function
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString('token');
  String username=prefs.getString('username');
  String idcourse=prefs.getString('idcourse');
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/courses/$idcourse', {
      'token':"$token"
    });

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
  Map<String,dynamic> re=json.decode(response.body);
  InCourse ic =InCourse.fromJson(re);
  await Future.delayed(Duration(seconds: 3));
  return Future.value(ic);
}

Future<Student> getStudent() async { //  <--- async fun
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString('token');
  String username=prefs.getString('username');
  String idstudent=prefs.getString('idstudent');
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/students/$idstudent', {
      'token':"$token"
    });

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
  print(response.body.toString());
  Map<String,dynamic> re=json.decode(response.body);
  Student st =Student.fromJson(re);
  
  await Future.delayed(Duration(seconds: 3));
  return Future.value(st);
}

Future<Student> getProfessor() async { //  <--- async fun
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString('token');
  String username=prefs.getString('username');
  String idprofessor=prefs.getString('idprofessor');
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/professors/$idprofessor', {
      'token':"$token"
    });

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
  print(response.body.toString());
  Map<String,dynamic> re=json.decode(response.body);
  Student st =Student.fromJson(re);
  
  await Future.delayed(Duration(seconds: 3));
  return Future.value(st);
}

Future<AllStudents> getDataStudents() async { //  <--- async function
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString('token');
  String username=prefs.getString('username');
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/students', {
      'token':"$token"
    });

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
  List<dynamic> re=json.decode(response.body);
  AllStudents ic =AllStudents.fromJson(re);
  await Future.delayed(Duration(seconds: 3));
  return Future.value(ic);
}

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
      title: Text("Re-Enter to see changes"),
      content: Text(""),
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

Future<bool> createStudent() async { //  <--- async function
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString('token');
  String username=prefs.getString('username');
  String idcourse=prefs.getString('idcourse');
  Uri uri = Uri.https("movil-api.herokuapp.com", '$username/students', {
      'token':"$token"
    });

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'courseId': idcourse
      }),
    );
  print(json.decode(response.body));
  return true;
}