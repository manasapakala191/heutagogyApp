import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';

class CustomMainAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("Heutagogy",style: TextStyle(color: HexColor('#ed2a26'),),),
      iconTheme: IconThemeData(
        color: HexColor("#ed2a26"),
      ),
    );
  }
}
