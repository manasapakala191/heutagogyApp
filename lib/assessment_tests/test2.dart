import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heutagogy/data_models.dart';

class Test2Page extends StatefulWidget {
  final Test2Data test2data;

  Test2Page(this.test2data, {Key key}) : super(key: key);

  @override
  _Test2PageState createState() => _Test2PageState(test2data);
}

class _Test2PageState extends State<Test2Page> {
  Test2Data test2data;
  Map<String, bool> correct;

  _Test2PageState(Test2Data data) {
    this.test2data = data;
    this.correct = Map();
    for (var image in this.test2data.pictures) {
      correct[image.description] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          (test2data.heading == "" || test2data.heading == null)
              ? Container()
              : Center(
            child: Text(
              test2data.heading,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20),),
          Column(
            children: _builder(correct),
          ),
        ],
      ),
    );
  }

  List<Widget> _builder(Map correct) {
    List<Widget> body = [];
    List<Widget> drops = [];
    List<Widget> targets = [];

    for (var image in test2data.pictures) {
      if (correct[image.description]) {
        drops.add(Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: Color.fromARGB(20, 10, 40, 230),
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.assignment_turned_in,
              color: Colors.blue,
              size: 32,
            )));
      } else {
        drops.add(DraggableImage(image: image, active: correct[image.description]));
      }
      targets.add(
        DragTarget(
          builder: (BuildContext context, List<String> incoming, List rejected) {
            if (!correct[image.description]) {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 128,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue, width: 2),
                      color: Colors.blueAccent),
                  padding: EdgeInsets.all(10),
                  height: 128,
                  child: Center(
                      child: Text(
                    image.description,
                    style:
                        TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 128,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black54, width: 2),
                        color: Colors.blueAccent),
                    padding: EdgeInsets.all(10),
                    height: 128,
                    child: Center(
                      child: Text(
                        "Matched",
                        style: TextStyle(
                            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              );
            }
          },
          onAccept: (data) {
            setState(() {
              correct[data] = true;
            });
          },
          onLeave: (data) {},
          onWillAccept: (data) => data == image.description,
        ),
      );
    }
    targets..shuffle(Random(2));
    for (int i = 0; i < this.test2data.pictures.length; i++) {
      body.add(Padding(
          padding: EdgeInsets.only(top: 3, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[drops[i], targets[i]],
          )));
    }
    return body;
  }
}

class DraggableImage extends StatelessWidget {
  final PicturePairData image;
  final bool active;

  DraggableImage({this.image, this.active});

  @override
  Widget build(BuildContext context) {
    if (!this.active) {
      return Draggable<String>(
          data: image.description,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: image.picture,
              width: 128,
              height: 128,
              placeholder: (context, data) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 500),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          feedback: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              placeholderFadeInDuration: Duration(milliseconds: 100),
              imageUrl: image.picture,
              width: 128,
              height: 128,
            ),
            clipBehavior: Clip.hardEdge,
          ),
          childWhenDragging: Container(
            width: 128,
          ));
    } else {
      return ClipRect(
        child: Container(
          width: 128,
          height: 128,
          child: Center(
            child: Icon(
              Icons.assignment_turned_in,
              color: Colors.blueAccent,
            ),
          ),
          color: Colors.lightBlueAccent,
        ),
        clipBehavior: Clip.antiAlias,
      );
    }
  }
}
