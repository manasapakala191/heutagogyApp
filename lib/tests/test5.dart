import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';

class Test5Page extends StatefulWidget {
  final Test6Data test6data;

  Test5Page(this.test6data, {Key key}) : super(key: key);

  @override
  _Test5PageState createState() => _Test5PageState(test6data);
}

class _Test5PageState extends State<Test5Page> {
  Test6Data test6data;
  Map<String, bool> data;

  _Test5PageState(this.test6data);

  @override
  void initState() {
    super.initState();
    data = Map<String, bool>();
    for (var x in test6data.choices) {
      data[x.correctText] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildImageInput(),
    );
  }

  _buildImageInput() {
    List<Widget> items = [];
    if (test6data.heading != null && test6data.heading != "")
      items.add(Text(
        test6data.heading,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
    for (var x in test6data.choices) {
      items.add(
        Column(
          key: ObjectKey(x),
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: x.picture,
              width: 250,
              height: 250,
            ),
            (!data[x.correctText])
                ? Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    key: UniqueKey(),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type here",
                      ),
                      onChanged: (txt) {
//                    print(txt);
                        if (x.correctText.toString().toLowerCase() == txt.toLowerCase()) {
                          setState(() {
                            data[txt] = true;
                          });
                        }
                      },
                      readOnly: (data[x.correctText]),
                      style: TextStyle(fontSize: 16),
                    ))
                : Container(
                    key: UniqueKey(),
                    height: 45.00,
                    margin: EdgeInsets.only(
                        top: 10, bottom: 20, left: 50, right: 50),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        x.correctText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
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
    items.add(Padding(
      padding: EdgeInsets.only(bottom: 40),
    ));
    return items;
  }
}
