import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heutagogy/screens/course_screen.dart';
import 'package:heutagogy/screens/login-resources/register.dart';

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

  @override
  Widget build(BuildContext context) {
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
                          height: MediaQuery.of(context).size.height * 1 / 2,
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
                                        setState(() {
                                          _obscure = !_obscure;
                                        });
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
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CourseScreen()));
                                    //TODO: Uncomment and integrate
                                    // if (_formKey.currentState.validate()) {
                                    //   //TODO: Register function here
                                    // }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
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
                                    //TODO: Go to the Register page
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisterPage()));
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
