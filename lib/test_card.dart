import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Page001 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page001State();
}

class _Page001State extends State<Page001> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text("Page001"),
      ),
      body: SafeArea(
        child: simpleBody(),
      ),
    );
  }
}

Widget simpleBody() {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          MyCard(colorTheme: Colors.orangeAccent),
          MyCard(colorTheme: Colors.yellowAccent),
          MyCard(colorTheme: Colors.blueAccent),
          MyCard(colorTheme: Colors.lightBlueAccent),
          MyCard(colorTheme: Colors.pinkAccent),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
          ),
        ],
      ),
    ),
  );
}

class MyCard extends StatefulWidget {
  final Color colorTheme;
  MyCard({Key key, this.colorTheme}) : super(key: key);

  _MyCardState createState() => _MyCardState(colorTheme);
}

class _MyCardState extends State<MyCard> {
  bool isStarred;
  double progress;
  Color colorTheme;

  _MyCardState(this.colorTheme);

  @override
  void initState() {
    isStarred = false;
    progress = 0.5;
    super.initState();
  }

  onDecrease() {
    setState(() {
      progress -= (progress == 0) ? 0 : 0.1;
    });
  }

  onIncrease() {
    setState(() {
      progress += (progress == 1) ? 1 : 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blueAccent  , style: BorderStyle.solid, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding (
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Lesson 1: Story",
                style: TextStyle(
                  fontSize: 20, fontFamily: 'Nunito',
                ),
              ),              
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Text(
                "Let\'s read a story, learn something wonderful and answer the questions.",
                style: TextStyle(
                  fontSize: 16, fontFamily: 'Nunito',
                ),
              ),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Decrease"),
                    onPressed: onDecrease,
                  ),
                  FlatButton(
                    child: Text("Increase"),
                    onPressed: onIncrease,
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(colorTheme),
            ),
          ],
        ),
      ),
    );
  }
}
