library splashscreen;

import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  // final Text title;
  final title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;
  SplashScreen(
      {this.loaderColor,
      @required this.seconds,
      this.photoSize,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText = const Text(""),
      this.imageBackground,
      this.gradientBackground});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), () {
      if (widget.navigateAfterSeconds is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      } else if (widget.navigateAfterSeconds is Widget) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => widget.navigateAfterSeconds));
      } else {
        throw new ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget');
      }
    });

    controller = new AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    animation =
        new CurvedAnimation(parent: controller, curve: Curves.elasticInOut)
          ..addListener(() {
            setState(() {
              //  debugPrint("${controller.val  ue}");
            });
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xfffc00ff), Color(0xff00dbde)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      body: new InkWell(
        onTap: widget.onClick,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // new Container(
            //   decoration: new BoxDecoration(
            //     image: widget.imageBackground == null
            //         ? null
            //         : new DecorationImage(
            //             fit: BoxFit.cover,
            //             image: widget.imageBackground,
            //           ),
            //     gradient: widget.gradientBackground,
            //     color: widget.backgroundColor,
            //   ),
            // ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  // flex: 2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //   new CircleAvatar(
                      //     backgroundColor: Colors.transparent,
                      //     child: new Container(
                      //         child: widget.image
                      //     ),
                      //     radius: widget.photoSize,
                      //   ),
                      // new Padding(
                      //   padding: const EdgeInsets.only(top: 10.0),
                      // ),
                      Text(
                        'Heutagogy',
                        style: TextStyle(
                          fontSize: 60 * animation.value,
                          foreground: Paint()..shader = linearGradient,
                          fontFamily: 'GloriaHallelujah',
                        ),
                      )
                    ],
                  )),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: animation.value == 1 ? 1.0 : 0.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: CircularProgressIndicator(
                            // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                      ),
                      widget.loadingText
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
