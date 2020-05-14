import 'package:converter_provider/screens/myhome.dart';
import 'package:converter_provider/widgets/future_builder_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
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
      content: Text("Need to relog"),
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
    List<String>placeholder=new List<String>();
    List<String>cc=screenState.courses;
    for (var x in cc??placeholder){
      placeholder.add(x);

    }
    //print(cc);
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerRight,
                child: Text(
                  screenState.username,
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
                  screenState.email,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Colors.green,
                      fontSize: 20),
                )),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: placeholder.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    color: Colors.green,
                    child: Center(
                      child: MaterialButton(child: Text('${placeholder[index]}',
                        style: TextStyle(fontSize: 15)),
                        onPressed:(){
                          screenState.validateToken().then((val){
                              if(val){
                                _changeCourse(placeholder[index].split(" ")[0]).then((val){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FutureBuilderCourse()),
                                  );
                                });
                              }else{
                                showAlertDialog(context);
                              }
                              
                            });
                          print('sashufhe');
                          
                          
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
                        heroTag: 'b1',
                        onPressed: () {
                          screenState.addCourse().then((cl){
                            if(cl.length==0){
                              showAlertDialog(context);
                            }
                            else screenState.changeCourses(cl);
                          });
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Colors.green,)),
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                        heroTag: 'b2',
                        onPressed: () {
                          screenState.initList().then((cl){
                            if(cl.length==0){
                              showAlertDialog(context);
                            }
                            else screenState.changeCourses(cl);
                          });
                        },
                        child: Icon(Icons.redo),
                        backgroundColor: Colors.green,)),
            
            Container(child:Expanded(child:Column(children:<Widget>[Expanded(flex:2,child: Row(
                        children: <Widget>[
                          Spacer(flex:1),
                          Expanded(flex:5,child: MaterialButton(
                          color: Colors.green,
                          onPressed: () {
                            screenState.validateToken().then((val){
                              if(val){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FutureBuilderAllStudents()),
                                );
                              }else{
                                showAlertDialog(context);
                              }
                              
                            });
                          },
                          child: Text("Students",
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              )))),
                          Spacer(flex:1),
                          Expanded(flex:5,child: MaterialButton(
                          color: Colors.green,
                          onPressed: () {
                            screenState.validateToken().then((val){
                              if(val){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FutureBuilderAllProfessors()),
                                );
                              }else{
                                showAlertDialog(context);
                              }
                              
                            });
                            
                          },
                          child: Text("Professors",
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              )))),
                        Spacer(flex:1),
                        ]
                    )),
                    Expanded(flex:1,child: Row(
                        
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Spacer(flex:1),
                          Expanded(flex:5,child:MaterialButton(
                          
                          color: Colors.green,
                          onPressed: () {
                            screenState.change_state();
                            _changeState();
                          },
                          child: Text("Sign Out",
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              )))),
                          Spacer(flex:1),
                          Expanded(flex:5,child:MaterialButton(
                          
                          color: Colors.green,
                          onPressed: () {
                            screenState.validateToken().then((val){
                              if(val){
                                screenState.restartDB().then((vali){
                                  screenState.change_state();
                                  _changeState();
                                });
                              }else showAlertDialog(context);
                            });
                            
                          },
                          child: Text("Restart",
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              )))),
                          Spacer(flex:1),
                        ]
                    )),
                  ]))
            ),
        
      ]),
    );
  }
  
  _changeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('screen', true);
  }
  
  Future<bool> _changeCourse(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idcourse', s);
  }
}