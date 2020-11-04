import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey_1 = GlobalKey<FormState>();
  final _formKey_2 = GlobalKey<FormState>();
  final _formKey_3 = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass_1 = TextEditingController();
  final TextEditingController _pass_2 = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        title: Text(
          "My Profile",
        ),
      ),
      body: Container(
        //color: HexColor("#ed2a26"),
        child: ListView(
          children: [
            Container(
              child: Container(
                child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/empty_account_circle.png",
                    image: "lol"),
              ),
              margin: EdgeInsets.all(50.0),
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                /*
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/empty_account_circle.png"),
                  //fit: BoxFit.cover,
                ),
                */
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Text(
                "Change you name :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey_1,
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Type you new name here",
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: RaisedButton(
                onPressed: () {},
                color: HexColor("#ed2a26"),
                child: Text("Change name", style: TextStyle(color: Colors.white),),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Text(
                "Reset your password:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey_2,
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: TextFormField(
                  obscureText: _obscure1,
                  controller: _pass_1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Type you new password here",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon:
                    IconButton(
                      icon: _obscure1
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscure1 = !_obscure1;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    String ans;
                    if (val.isEmpty) {
                      ans = "Please type in new password";
                    }
                    return ans;
                  },
                ),
              ),
            ),
            Form(
              key: _formKey_3,
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: TextFormField(
                  controller: _pass_2,
                  obscureText: _obscure2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Type you new password here again",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon:
                    IconButton(
                      icon: _obscure2
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscure2 = !_obscure2;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    String ans;
                    if (val.isEmpty) {
                      ans = "Please type in new password";
                    }
                    if (_pass_1.text !=
                        _pass_2.text) {
                      ans = "Your new passwords do not match";
                    }
                    return ans;
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: RaisedButton(
                onPressed: () {},
                color: HexColor("#ed2a26"),
                child: Text("Reset password", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
