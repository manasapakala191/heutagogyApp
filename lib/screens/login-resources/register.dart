import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heutagogy/screens/misc-screens/buffer_screen.dart';
import 'package:provider/provider.dart';
import '../../models/userModel.dart';
import '../../services/database.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _newPassword1 = TextEditingController();
  final TextEditingController _newPassword2 = TextEditingController();
  String error;
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _obscure3 = true;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: SvgPicture.asset(
                "assets/images/sign.svg",
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width*10,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              //color: Colors.white,
              child: Center(
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                        padding : EdgeInsets.all(10.0),
                        child: Text(
                          "HEUTAGOGY",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 5 / 7,
                        margin: EdgeInsets.all(30.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 10.0)
                          ],
                        ),
                        child: ListView(
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              child: TextFormField(
                                controller: _rollNumberController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Roll-Number",
                                ),
                                validator: (val) {
                                  String ans;
                                  if (val.isEmpty) {
                                    ans = "Please type in your Roll-Number";
                                  }
                                  return ans;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: TextFormField(
                                controller: _password,
                                obscureText: _obscure1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Password",
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
                                    ans =
                                        "Please type in the password given by your teacher";
                                  }
                                  return ans;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: TextFormField(
                                controller: _newPassword1,
                                obscureText: _obscure2,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "New-Password",
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
                                  return ans;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: TextFormField(
                                controller: _newPassword2,
                                obscureText: _obscure3 ,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Confirm new password",
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon:
                                      IconButton(
                                        icon: _obscure3
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _obscure3 = !_obscure3;
                                          });
                                        },
                                      ),
                                ),
                                validator: (val) {
                                  String ans;
                                  if (val.isEmpty) {
                                    ans = "Please fill in your password";
                                  }
                                  if (_newPassword1.text !=
                                      _newPassword2.text) {
                                    ans = "Your new passwords do not match";
                                  }
                                  return ans;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: RaisedButton(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.red,
                                onPressed: () async {
                                  //TODO: Uncomment and Integrate
                                  if (_formKey.currentState.validate()) {
                                  //   //TODO: Register function here
                                  var result = await DatabaseService().signUpStudent(userModel,_rollNumberController.text, _password.text, _newPassword2.text);
                                  print(result);
                                  if(result == true){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BufferPage()));
                                  }else{
                                    print("Error in performing action");
                                  }
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: RaisedButton(
                                child: Text(
                                  "Sign In ?",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    //color: Colors.white,
                                  ),
                                ),
                                elevation: 0.0,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
