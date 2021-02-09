import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  CustomAppBar({this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title,style: TextStyle(color: HexColor('#ed2a26')),),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: HexColor('#ed2a26'),),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
