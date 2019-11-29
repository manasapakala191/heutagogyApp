import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class Test8Page extends StatefulWidget {
  @override
  _Test8PageState createState() => _Test8PageState();
}

class _Test8PageState extends State<Test8Page> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(),
          Container(),
//        _buildWidgets()
        ],
      ),
    );
  }

  _buildWidgets() {
    List<Widget> my_widgets = [];

    return Column(
      children: my_widgets,
    );
  }
}
