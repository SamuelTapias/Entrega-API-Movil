import 'package:converter_provider/screens/myhome.dart';
import 'package:converter_provider/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatelessWidget {
  
  
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    return  Scaffold(
            appBar: AppBar(
              title: Text('Class demo login'),
            ),
            body: Center(child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  
                  
                  MyCustomForm2(),
                  
                  
                ]),
            )));
      
    
  }

  
}