import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentPerformance.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class MatchText extends StatefulWidget {
  @override
  _MatchTextState createState() => _MatchTextState();
}

class _MatchTextState extends State<MatchText> {
  MatchPicWithText _matchPicWithText;
  Map<String, bool> data;
  var choices = Map();

  void _updateProgress(){
    var progress = Provider.of<StudentPerformance>(context,listen: false);
    List<String> responses = [];
    for (var response in choices.values) {
        responses.add(response);
    }
    progress.addResponses("0",responses);
    int count = 0, total = 0;
    for(var val in data.values){
      if(val == true){
        count++;
      }
      total++;
    }
    progress.setPerformance("0",count,total);
    DatabaseService().writeProgress(progress.getPerformance(),"0");
  }

  @override
  void initState() {
    // Uncomment the following to test this out

    _matchPicWithText = new MatchPicWithText(
      testName: "Lorem ipsum",
      testDescription: "Type the name of the picture in the given box:",
      subject: "Something",
      choices: [
        PictureData(
          picture:
              "http://may123.pythonanywhere.com/media/picture_text_input/baby.png",
          correctText: "baby",
        ),
        PictureData(
          picture:
              "http://may123.pythonanywhere.com/media/picture_text_input/cat_XTqprK4.png",
          correctText: "cat",
        ),
      ],
    );


    data = Map<String, bool>();
    for (var choice in _matchPicWithText.choices) {
      data[choice.correctText] = false;
      choices[choice.correctText] = null;
    }
    super.initState();
  }

  List<Widget> _buildImageInput() {
    List<Widget> items = [];
    if (_matchPicWithText.testDescription != null &&
        _matchPicWithText.testDescription != "") {
      items.add(
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            _matchPicWithText.testDescription,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    for (var x in _matchPicWithText.choices) {
      items.add(
        Column(
          key: ObjectKey(x),
          children: <Widget>[
            SizedBox(height: 20.0),
            CachedNetworkImage(
              imageUrl: x.picture,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            (!data[x.correctText])
                ? Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    // key: UniqueKey(),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor("#ed2a26"), width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type here",
                      ),
                      onChanged: (txt) {
                        if (x.correctText.toString().toLowerCase() ==
                            txt.toLowerCase()) {
                          setState(() {
                            data[txt] = true;
                            choices[txt] = txt;
                          });
                        }
                        else{
                          choices[x.correctText] = txt;
                        }
                      },
                      readOnly: (data[x.correctText]),
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : Container(
                    // key: UniqueKey(),
                    height: 45.00,
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    decoration: BoxDecoration(
                      color: Colors.green,
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        x.correctText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      );
    }
    items.add(
      Padding(
        padding: EdgeInsets.only(bottom: 40),
      ),
    );
    items.add(
      MaterialButton(
        minWidth: 25,
        height: 75,
        elevation: 8,
        child: Text("Submit"),
        color: HexColor("#ed2a26"),
        padding: const EdgeInsets.all(5),
        onPressed: (){
          _updateProgress();
          Navigator.pop(context);
        },
      ),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    //_buildImageInput();
    return Scaffold(

      appBar: AppBar(
        title: Text(_matchPicWithText.testName),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
        iconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
      ),
      body: Center(
        child: ListView(
          children: _buildImageInput(),
        ),
      ),
    );
  }
}
