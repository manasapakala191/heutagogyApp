import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/userModel.dart';
import 'package:provider/provider.dart';
import '../courses_screen.dart';

class BufferPage extends StatefulWidget {
  @override
  _BufferPageState createState() => _BufferPageState();
}

class _BufferPageState extends State<BufferPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _photoUrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
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
                                    "Fill in these extra details:",
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
                                  controller: _fullName,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Full Name",
                                    prefixIcon: Icon(Icons.account_circle),
                                  ),
                                  validator: (val) {
                                    String ans;
                                    if (val.isEmpty) {
                                      ans = "Please type in your Full Name";
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
                                  controller: _photoUrl,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Your Photo",
                                    //Icon(Icons.remove_red_eye_outlined),
                                    prefixIcon: Icon(Icons.add_a_photo),
                                  ),
                                  validator: (val) {
                                    String ans;
                                    if (val.isEmpty) {
                                      ans = "Please type in the photoUrl";
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
                                    "Continue to the app",
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
                                    //TODO: Uncomment and integrate
                                    // if (_formKey.currentState.validate()) {
                                    //   //TODO: Take name and photoUrl and integrate it
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
                                    "Skip ahead ->",
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
                                        builder: (context) => CoursesHomeScreen()
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
