import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class CustomFloatingActionButton extends StatefulWidget {
   final GlobalKey<ScaffoldState> scaffoldkey;

   CustomFloatingActionButton({this.scaffoldkey});
  @override
  _CustomFloatingActionButtonState createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  final _formCourseKey = GlobalKey<FormState>();
  String courseCode = "";
  bool add;

   showAdding(String roll, UserModel userModel) {
    final _screenSize = MediaQuery.of(context).size;
    return widget.scaffoldkey.currentState
        .showSnackBar(SnackBar(
          content: Container(
            height: _screenSize.height * 0.03,
            child: FutureBuilder(
                future: DatabaseService.courseFilter(courseCode),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        add = true;
                        DatabaseService.addNewCourse(courseCode, roll);
                        return Icon(Icons.check_circle);
                      } else {
                        add = false;
                        return Text("No such course code");
                      }
                    } else if (snapshot.hasError) {
                      return Text("Problem!");
                    }
                  }
                  return Container(
                      height: _screenSize.height * 0.03,
                      width: _screenSize.width * 0.3,
                      child: Center(child: CircularProgressIndicator()));
                }),
          ),
        ))
        .closed
        .then((value) {
      print(add);
      if (add) userModel.addCourse(courseCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final userModel = Provider.of<UserModel>(context);
    return FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: HexColor("#ed2a26"),
        onPressed: () async {
          bool add = false;
          bool added = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                    actions: [
                      FlatButton(
                          onPressed: () {
                            print(courseCode);
                            if (_formCourseKey.currentState.validate()) {
                              _formCourseKey.currentState.save();
                              Navigator.pop(context, true);
                            }
                          },
                          child: Text("Add")),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text("Cancel"))
                    ],
                    title: Text('Add New Course'),
                    content: Container(
                      width: _screenSize.width * 0.3,
                      child: Form(
                        key: _formCourseKey,
                        child: TextFormField(
                          onSaved: (val) {
                            setState(() {
                              courseCode = val;
                            });
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              print("empty");
                              return "Type a course code.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ));
          if (added) {
            await showAdding(userModel.roll, userModel);
          }
        },
      );
  }
}