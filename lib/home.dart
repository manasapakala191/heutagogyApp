import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  // backgroundColor: Colors.lightGreenAccent,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        centerTitle: true,
                        title: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: top <= 140.0 ? 1.0 : 0.0,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        
                        background: Image.asset(
                          "assets/images/books.jpg",
                          // "https://d3ui957tjb5bqd.cloudfront.net/uploads/images/3/36/36367.pic.jpg?1463997427",
                          // "https://images.unsplash.com/photo-1455884981818-54cb785db6fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1890&q=80",
                          // "https://images.unsplash.com/photo-1455884981818-54cb785db6fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1890&q=80",
                          // "https://images.unsplash.com/photo-1539795845756-4fadad2905ec?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
                          fit: BoxFit.fill,
                          // alignment: Alignment.topLeft,
                        ),
                      );
                    },
                  )),
            ];
          },
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Center(
                  child: Text(
                    "Choose any lesson to begin",
                    style: TextStyle(
                      fontSize: 25,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Lesson(
                title: "Lesson 1",
                summary:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                borderColor: Colors.orangeAccent,
              ),
              Lesson(
                title: "Lesson 2",
                borderColor: Colors.greenAccent,
              ),
              Lesson(
                title: "Lesson 3",
                borderColor: Colors.redAccent,
              ),
              Lesson(
                title: "Lesson 4",
                borderColor: Colors.lightBlueAccent,
              ),
              Lesson(
                title: "Lesson 5",
                borderColor: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Lesson extends StatelessWidget {
  final String title;
  final String summary;
  final Color borderColor;
  final dynamic func;

  Lesson(
      {this.title = "Title",
      this.summary =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
      this.borderColor = Colors.blue,
      this.func});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Divider(
                  thickness: 1,
                  // color: borderColor,
                ),
                Text(
                  summary,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
