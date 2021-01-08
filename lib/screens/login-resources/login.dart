//import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heutagogy/screens/courses_screen.dart';
import 'package:heutagogy/screens/login-resources/register.dart';
import 'package:provider/provider.dart';
import '../../models/userModel.dart';
import '../../services/database.dart';
import '../courses_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  AnimationController _animationController;
  bool isTransitioning = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void changeTransition() {
    setState(() {
      isTransitioning = !isTransitioning;
      isTransitioning
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  var loading;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              child: SafeArea(
                child: Center(
                  child: ListView(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
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
                          margin: EdgeInsets.all(30.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 10.0)
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscure,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: !isTransitioning
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                      onPressed: () {
                                        changeTransition();
                                        setState(
                                          () {
                                            _obscure = !_obscure;
                                          },
                                        );
                                      },
                                    ), //Icon(Icons.remove_red_eye_outlined),
                                  ),
                                  validator: (val) {
                                    String ans;
                                    if (val.isEmpty) {
                                      ans = "Please type in the password";
                                    }
                                    return ans;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 50.0,
                                child: RaisedButton(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: Colors.red,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        loading = CircularProgressIndicator();
                                      });
                                      var result = await DatabaseService()
                                          .signInStudent(
                                              userModel,
                                              _rollNumberController.text,
                                              _passwordController.text);
                                      if (result == "Success") {
                                        setState(
                                          () {
                                            loading = Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Success !",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CoursesHomeScreen(),
                                          ),
                                        );
                                      } else if (result == "User not found") {
                                        setState(() {
                                          loading = Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                child: Text(
                                                  "R.No not found. Please sign up first !",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                        print("User not found");
                                      } else if (result == "Wrong password") {
                                        setState(
                                          () {
                                            loading = Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Wrong password, please try again !",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        setState(
                                          () {
                                            loading = Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Something went wrong, please try again later.",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: loading,
                              ),
                              Container(
                                child: RaisedButton(
                                  child: Text(
                                    "Create an account?",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      //color: Colors.white,
                                    ),
                                  ),
                                  elevation: 0.0,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
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
            ),
          ],
        ),
      ),
    );
  }
}
