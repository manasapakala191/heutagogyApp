import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
        backgroundColor: HexColor('#ed2a26'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){},
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
