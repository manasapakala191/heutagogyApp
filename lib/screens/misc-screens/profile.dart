import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  String _imageURL;
  bool _resetPassword = false;
  final imagePicker = ImagePicker();
  Widget resetPassword;
  Widget resetName;

  final _formKey_name = GlobalKey<FormState>();
  final _formKey_reset = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _pass_1 = TextEditingController();
  final TextEditingController _pass_2 = TextEditingController();

  bool _obscure0 = true;
  bool _obscure1 = true;
  bool _obscure2 = true;

  Future pickImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('studentProfileImages/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print("Uploaded"));
    taskSnapshot.ref.getDownloadURL().then((value) {
      print("Done: $value");
      setState(() {
        _imageURL = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Profile",
        ),
      ),
      body: Container(
        //color: HexColor("#ed2a26"),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: InkWell(
                onTap: (){
                  pickImage();
                  if(_image!=null){
                    uploadImageToFirebase();
                  }
                },
                  child: userModel.photoURL!=null && userModel.photoURL.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder: "assets/images/empty_account_circle.png",
                          image: _imageURL != null ? _imageURL : "No image")
                      : Image.asset(
                          "assets/images/empty_account_circle.png",
                        )),
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
                "Change your name :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey_name,
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
                    labelText: "Type your new name here",
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: RaisedButton(
                onPressed: () {
                  _formKey_name.currentState.save();
                  DatabaseService.updateProfileName(_name.text, userModel);
                  setState(() {
                    resetName = Container(
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ),
                    );
                  });
                },
                color: HexColor("#ed2a26"),
                child: Text(
                  "Change name",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            resetName ?? Container(),
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _resetPassword = !_resetPassword;
                  });
                  print(_resetPassword);
                },
                child: Text(
                  "Reset your password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _resetPassword
                ? Form(
                    key: _formKey_reset,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: TextFormField(
                            obscureText: _obscure1,
                            controller: _pass,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Current Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: _obscure1
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscure0 = !_obscure0;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              String ans;
                              if (val.isEmpty) {
                                ans = "Please type password";
                              } else if (val != userModel.currentPassword) {
                                ans = "Wrong password, try again!";
                              }
                              return ans;
                            },
                          ),
                        ),
                        Container(
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
                              labelText: "New password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
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
                        Container(
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
                              labelText: "New password again",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
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
                              if (_pass_1.text != _pass_2.text) {
                                ans = "Passwords do not match";
                              }
                              return ans;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey_reset.currentState.validate()) {
                                if (_pass_1.text == _pass_2.text) {
                                  DatabaseService.updatePassword(
                                      _pass_1.text, userModel);
                                  setState(() {
                                    resetPassword = Container(
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                    );
                                  });
                                }
                              }
                            },
                            color: HexColor("#ed2a26"),
                            child: Text(
                              "Reset password",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        resetPassword ?? Container(),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
