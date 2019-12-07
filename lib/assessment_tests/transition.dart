import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class TransitionPage extends StatefulWidget{
  final String subject;
  TransitionPage({this.subject});
  @override
  _TransitionPageState createState()=>_TransitionPageState();
}
class _TransitionPageState extends State<TransitionPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.subject.toUpperCase(),style: TextStyle(fontSize:36 ),),
        ],
      ),
    );
  }
}