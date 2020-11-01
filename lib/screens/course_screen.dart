import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentPerformance.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';
import 'package:heutagogy/screens/lessons_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/screens/login-resources/register.dart';
import 'package:heutagogy/screens/test_screens/drag_drop_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/match_audio.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/screens/test_screens/match_text_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:heutagogy/screens/test_screens/math_match_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_question_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  // void initState() {
  //   fetchData();
  //   // TODO: implement initState
  //   super.initState();
  // }

  // void fetchData() async {
  //   await Firebase.initializeApp();
  //   DatabaseService.getUserDoc('123');
  // }

  var dragdropJSON = {
    "name": "L1_Q1",
    "heading": "Match Correct Actions With The Picture",
    "pictures": [
      {
        "picture": "https://may123.pythonanywhere.com/media/picture_description_pair/class.png",
        "description": "A boy folding hands in front of his teacher"
      },
      {
        "picture": "https://may123.pythonanywhere.com/media/picture_description_pair/water_1.png",
        "description": "A girl giving water to her grand father"
      },
      {
        "picture": "https://may123.pythonanywhere.com/media/picture_description_pair/litter31copy.png",
        "description": "A girl clearing litter on the road"
      },
      {
        "picture": "https://may123.pythonanywhere.com/media/picture_description_pair/cooking.png",
        "description": "A boy cooking food along with his father"
      },
    ],
    "audios":[
        {
          "audio": "https://may123.pythonanywhere.com/media/audio_description_pair/cat.mp3",
          "description": "Cat"
        },
        {
          "audio": "https://may123.pythonanywhere.com/media/audio_description_pair/cuckoo.mp3",
          "description": "Cuckoo"
        },
        {
          "audio": "https://may123.pythonanywhere.com/media/audio_description_pair/dog.mp3",
          "description": "Dog"
        },
        {
          "audio": "https://may123.pythonanywhere.com/media/audio_description_pair/horse.mp3",
          "description": "Horse"
        }
      ],
     "questions":[
        {
          "first": "953",
          "second": "900 + 50 + 3"
        },
        {
          "first": "215",
          "second": "200 + 10 + 5"
        },
        {
          "first": "674",
          "second": "600 + 70 + 4"
        },
        {
          "first": "598",
          "second": "500 + 90 + 8"
        },
        {
          "first": "751",
          "second": "700 + 50 + 1"
        }
      ],
     "subject": "",
  };
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
        iconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(height:50),
              RaisedButton(
                color: Colors.redAccent,
            onPressed:(){
              Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => RegisterPage()));
            },
            child: Text("Register",style: TextStyle(color: Colors.white),)),
            RaisedButton(
              color: Colors.redAccent,
            onPressed:(){
              Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => LoginPage()));
            },
            child: Text("Login",style: TextStyle(color: Colors.white),)),
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        backgroundColor: HexColor("#ed2a26"),
        onPressed: (){},
      ),
      body: Consumer<StudentPerformance>(
        builder: (context, progress,child) {
          return Container(
            child: _buildSlides(dragdropJSON),
          );
        }
      ),
    );
  }

  _returnSlideScreen(String type,var data){
    switch(type){
      case 'l0':{
        return LessonViewer();
      } break;
      case 'q0':{
        return MatchText();
      } break;
      case 'q1':{
        return MultipleChoiceImageQuestionScreen();
      } break;
      case 'q2':{
        return MultipleChoiceQuestionScreen();
      } break;
      case 'q3': {
        return DragDropImageScreen(DragDropImageTest.fromJSON(data));
      } break;
      case 'q4': {
        return DragDropAudioScreen(DragDropAudioTest.fromJSON(data));
      }break;
       case 'q5': {
        return MathMatchScreen(MathMatchTest.fromJSON(data));
      }break;
      default: {
        return Container(
          child: Text("No Such Type"),
        );
      } break;
    }
  }
  _buildSlides(Map data){
    List types=['l0','q0','q1','q2','q3','q4','q5'];
    return ListView.builder(
        itemCount: 7,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context,int idx ){
         return Padding(
             padding: EdgeInsets.all(20),
             child: Card(
                 clipBehavior: Clip.antiAlias,
                 elevation: 3,
                 shape: RoundedRectangleBorder(
                   side: BorderSide(color: HexColor("#ed2a26"), style: BorderStyle.solid, width: 1.0),
                   borderRadius: BorderRadius.circular(16.0),
                 ),
                 child: InkWell(
                     splashColor: Color.fromARGB(40, 0, 0, 200),
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => _returnSlideScreen(types[idx], data)));
                     },
                     child: Column(mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           Padding(
                             padding: EdgeInsets.only(top: 16),
                             child: Hero(
                               tag: types[idx],
                               child: Material(
                                 color: Colors.transparent,
                                 child: Text(
                                   "Fill In The Blanks",
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontFamily: 'Nunito',
                                   ),
                                 ),
                               ),
                             ),
                           ),
                           Divider(
                             color: Colors.black87,
                           ),
                           Padding(
                               padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                               child: Text(
                                 "Give Test",
                                 style: TextStyle(
                                   fontSize: 16,
                                   fontFamily: 'Nunito',
                                 ),
                               ))
                         ]))));
        });
  }
}

