import 'package:converter_provider/screens/myhome.dart';
import 'package:converter_provider/widgets/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'startscreen.dart';

class Converter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final screenState=Provider.of<Screen>(context,listen: true);
    screenState.init();
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            Expanded(child : (screenState.screen)? StartScreen():HomeScreen())
            ]),
    );
  }

  

}
