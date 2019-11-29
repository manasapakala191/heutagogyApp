import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconsize;
  final Duration animationduration;
  final Function onTap;
  final double radius;

  AnimatedButton({
    this.initialText,
    this.finalText,
    this.buttonStyle,
    this.iconData,
    this.iconsize,
    this.animationduration,
    this.onTap,
    this.radius,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ButtonStates _currentstate;
  Duration _smallDuration;

  @override
  void initState() {
    super.initState();
    _smallDuration = Duration(
        milliseconds: (widget.animationduration.inMilliseconds * 0.2).round());
    _controller =
        AnimationController(vsync: this, duration: widget.animationduration);
    _currentstate = ButtonStates.ONLY_TEXT;
    _controller.addListener(() {
      double controllerValue = _controller.value;
      if (controllerValue < 0.2) {
        setState(() {
          _currentstate = ButtonStates.ONLY_ICON;
        });
      } else {
        setState(() {
          _currentstate = ButtonStates.BOTH;
        });
      }
    });
    _controller.addStatusListener((currentStatus){
      if(currentStatus==AnimationStatus.completed){
        return widget.onTap();
      }
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  Widget build(BuildContext context) {
    return Material(
        elevation: widget.buttonStyle.elevation,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            _controller.forward();
          },
          child: AnimatedContainer(
            duration: _smallDuration,
            height: widget.iconsize + 20,
            decoration: BoxDecoration(
              color: (_currentstate == ButtonStates.ONLY_TEXT)
                  ? widget.buttonStyle.initialColour
                  : widget.buttonStyle.finalColour,
              border: Border.all(
                  color: (_currentstate == ButtonStates.ONLY_TEXT)
                      ? Colors.transparent
                      : widget.buttonStyle.initialColour),
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.00, vertical: 5.00),
            child: AnimatedSize(
              vsync: this,
              duration: _smallDuration,
              curve: Curves.easeInOut,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (_currentstate != ButtonStates.ONLY_TEXT)
                      ? Icon(
                          widget.iconData,
                          size: widget.iconsize,
                          color: widget.buttonStyle.initialColour,
                        )
                      : Container(),
                  (_currentstate == ButtonStates.ONLY_TEXT)
                      ? Text(
                          widget.initialText,
                          style: widget.buttonStyle.intialTextstyle,
                        )
                      : Container(),
                  SizedBox(
                    width: (_currentstate == ButtonStates.BOTH) ? 15 : 5,
                  ),
                  (_currentstate == ButtonStates.BOTH)
                      ? Text(
                          widget.finalText,
                          style: widget.buttonStyle.finalTextStyle,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ));
  }
}

class ButtonStyle {
  final TextStyle intialTextstyle, finalTextStyle;
  final Color initialColour, finalColour;
  final double elevation;

  ButtonStyle(
      {this.intialTextstyle,
      this.finalTextStyle,
      this.initialColour,
      this.finalColour,
      this.elevation});
}

enum ButtonStates {
  ONLY_TEXT,
  ONLY_ICON,
  BOTH,
}
