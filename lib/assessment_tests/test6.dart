import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Test6Page extends StatefulWidget {
  Test6Page({Key key}) : super(key: key);

  @override
  _Test6PageState createState() => _Test6PageState();
}

class _Test6PageState extends State<Test6Page> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "క్రింది బొమ్మలు చూసి పదాలు సరిగా ఉన్నవో లేదో టిక్‌ చెయ్యండి లేదా ౫ పెట్టండి",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        ImageChoicePuzzle(),
      ],
    );
  }
}

class ImageChoicePuzzle extends StatefulWidget {
  ImageChoicePuzzle({Key key}) : super(key: key);

  @override
  _ImageChoicePuzzleState createState() => _ImageChoicePuzzleState();
}

class _ImageChoicePuzzleState extends State<ImageChoicePuzzle> {
  List<ImageItem> imageItems = [
    ImageItem("assets/images/pb6/gaurd.png", "Gaurd", true),
    ImageItem("assets/images/pb6/spinach.png", "Spinach", false),
    ImageItem("assets/images/pb6/eggplant.png", "Eggplant", false),
    ImageItem("assets/images/pb6/jackfruit.png", "Jackfruit", false),
  ];
  List<bool> checked = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: _imageChoicesBuilder(),
      ),
    );
  }

  List<Widget> _imageChoicesBuilder() {
    List<Widget> myImages = [];
    for (int i = 0; i < imageItems.length; i++) {
      ImageItem img = imageItems[i];
      myImages.add((Container(
        width: 160,
        height: 180,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: ((checked[i]) ? Colors.green : Colors.blueAccent),
                width: (checked[i] ? 3 : 2))),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(19),
          child: Material(
            color: (checked[i] ? Color.fromARGB(40, 0, 200, 20) : Colors.transparent),
            child: InkWell(
              splashColor: (img.correct ? Colors.greenAccent : Colors.redAccent),
              onTap: () {
                if (img.correct){
                  setState(() {
                   checked[i] = true; 
                  });
                }
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    img.imageLink,
                    width: 150,
                    height: 140,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (checked[i] == true)
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Container(),
                      Text(img.itemName, style: TextStyle(fontSize: 16))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )));
    }
    return myImages;
  }
}

class ImageItem {
  final String imageLink;
  final String itemName;
  final bool correct;
  ImageItem(this.imageLink, this.itemName, this.correct);
}

//
// InkWell(
//   onTap: _onItemTap(i),
//   child: Container(
//     width: 160, height: 180,
//     margin: EdgeInsets.all(2),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         // color: Colors.blueAccent,
//         border: Border.all(
//             color:
//                 ((checked[i]) ? Colors.green : Colors.lightBlueAccent),
//             width: 2)),
//     child: Column(
//       children: <Widget>[
//         ClipRRect(
//           child: Image.asset(
//             img.imageLink,
//             width: 150,
//             height: 150,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           clipBehavior: Clip.antiAlias,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             (checked[i] == true)
//                 ? Icon(
//                     Icons.check,
//                     color: Colors.green,
//                   )
//                 : Container(),
//             Text(img.itemName, style: TextStyle(fontSize: 16))
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
