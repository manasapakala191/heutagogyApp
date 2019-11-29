import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Test5Page extends StatefulWidget {
  Test5Page({Key key}) : super(key: key);

  @override
  _Test5PageState createState() => _Test5PageState();
}

class _Test5PageState extends State<Test5Page> {
  List<FocusNode> inputFieldFocus = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
            Text(
              "సందడే సందడి పాటలో ఏ ఏ కూరగాయలు, పండ్లు న ప నులు చేసాయో జతపరచండి:",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              focusNode: inputFieldFocus[0],
              decoration: InputDecoration(
                labelText: "టమాట",
                labelStyle: TextStyle(fontSize: 24),
                hintText: "Enter Answer",
              ),
              style: TextStyle(fontSize: 20),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term){
                _fieldFocusChange(context, 0, 1);
              },
            ),
            TextFormField(
              focusNode: inputFieldFocus[1],
              decoration: InputDecoration(
                labelText: "ఆనపకాయ",
                labelStyle: TextStyle(fontSize: 24),
                hintText: "Enter Answer",
              ),
              style: TextStyle(fontSize: 20),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term){
                _fieldFocusChange(context, 1, 2);
              },
            ),
            TextFormField(
              focusNode: inputFieldFocus[2],
              decoration: InputDecoration(
                labelText: "పాలకూర",
                labelStyle: TextStyle(fontSize: 24),
                hintText: "Enter Answer",
              ),
              style: TextStyle(fontSize: 20),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term){
                _fieldFocusChange(context, 2, 3);
              },
            ),
            TextFormField(
              focusNode: inputFieldFocus[3],
              decoration: InputDecoration(
                labelText: "పనసప౦డు",
                labelStyle: TextStyle(fontSize: 24),
                hintText: "Enter Answer",
              ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, int i, int j){
    print("$i, $j");
    inputFieldFocus[i].unfocus();
    FocusScope.of(context).requestFocus(inputFieldFocus[j]);
  }
}
