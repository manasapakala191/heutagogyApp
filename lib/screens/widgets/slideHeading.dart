import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';

class SlideHeader extends StatelessWidget {
  final String testName;
  final String testDescription;
  SlideHeader({this.testName,this.testDescription});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          width: _screenSize.width*0.9,
          constraints: BoxConstraints(
            // maxHeight: _screenSize.height*0.8,
            minHeight: _screenSize.height*0.07,
          ),
          child: Column(
            children: [
              Text(testName, style: TextStyle(fontSize: 20)),
              Divider(
                color: HexColor("#ed2a26"),
                height: 10,
                thickness: 0.7,
              ),
              Text(testDescription, style: TextStyle(fontSize: 15)),
            ],
          ),
        ));
  }
}
