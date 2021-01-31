import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/services/database.dart';
import '../../hex_color.dart';

class DragDropAudioScreen extends StatefulWidget {

  final DragDropAudioTest data;
  final String courseID,lessonID,type;
  
  DragDropAudioScreen(this.data,this.type,this.courseID,this.lessonID, {Key key}) : super(key: key);
  
  @override
  _DragDropAudioScreenState createState() => _DragDropAudioScreenState(data);
}

class _DragDropAudioScreenState extends State<DragDropAudioScreen> {
  DragDropAudioTest audiodata;
  Map<String,dynamic> correct;
  var seed;
  Map<String,dynamic> choices;
  var leftMarked;
  var rightMarked;
  StudentProgress progress;

  _DragDropAudioScreenState(DragDropAudioTest data) {
    seed = Random().nextInt(100);
    this.audiodata = data;
    this.correct = Map<String,dynamic>();
    this.choices = Map<String,dynamic>();
    this.leftMarked = Map();
    this.rightMarked = Map();
    for (var audio in this.audiodata.audios) {
      correct[audio.description] = false;
      choices[audio.description] = null;
      leftMarked[audio.description] = false;
      rightMarked[audio.description] = false;
    }
  }

  void _updateProgress() {
    List<String> responses = [];
    var user = Provider.of<UserModel>(context,listen: false);
    String studentID = user.getID();
    for (var response in choices.values) {
      responses.add(response);
    }
    int count = 0, total = 0;
    for (var val in correct.values) {
      if (val == true) {
        count++;
      }
      total++;
    }
    var progress = Progress(name: audiodata.testName,description: audiodata.testDescription,partsDone: count,total: total,responses: responses);
    Map<String,dynamic> json = progress.toMap();
    DatabaseService().writeProgress(json,studentID,widget.courseID,widget.lessonID,widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          audiodata.testName,
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              (audiodata.testDescription == "" ||
                      audiodata.testDescription == null)
                  ? Container()
                  : Center(
                      child: Text(
                        audiodata.testDescription,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Column(
                children: _builder(audiodata, correct, seed),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _builder(DragDropAudioTest audiodata, Map correct, var seed) {
    List<Widget> body = [];
    List<Widget> drops = [];
    List<Widget> targets = [];
    for (var sound in audiodata.audios) {
      if (leftMarked[sound.description]) {
        drops.add(Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: Color.fromARGB(20, 10, 40, 230),
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.assignment_turned_in,
              color: HexColor("#ed2a26"),
              size: 32,
            )));
      } else {
        drops.add(DraggableAudioButton(
            audioPath: sound.description, active: correct[sound.description]));
      }
      targets.add(
        DragTarget(
          builder:
              (BuildContext context, List<String> incoming, List rejected) {
            if (!rightMarked[sound.description]) {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 128,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: HexColor("#ed2a26"), width: 2),
                      color: HexColor("#ed2a26")),
                  padding: EdgeInsets.all(10),
                  height: 128,
                  child: Center(
                      child: Text(
                    sound.description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 128,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black54, width: 2),
                        color: HexColor("#ed2a26")),
                    padding: EdgeInsets.all(10),
                    height: 128,
                    child: Center(
                      child: Text(
                        "Matched",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              );
            }
          },
          onAccept: (data) {
            print("This is correct :)");
            setState(() {
              correct[sound.description] = true;
              leftMarked[sound.description] = true;
              rightMarked[sound.description] = true;
              choices[sound.description] = sound.description;
            });
          },
          onLeave: (data) {
            print("This is wrong :(");
            print(sound.description);
            print(data);
            setState(() {
              choices[data] = sound.description;
              leftMarked[data] = true;
              rightMarked[sound.description] = true;
            });
          },
          onWillAccept: (data) => data == sound.description,
        ),
      );
    }
    targets..shuffle(Random(seed));
    for (int i = 0; i < audiodata.audios.length; i++) {
      body.add(Padding(
          padding: EdgeInsets.only(top: 3, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[drops[i], targets[i]],
          )));
    }
    body.add(SizedBox(height: 20));
    body.add(
      MaterialButton(
        height: 55,
        elevation: 8,
        child: Text("Submit"),
        color: HexColor("#ed2a26"),
        padding: const EdgeInsets.all(5),
        onPressed: () {
          _updateProgress();
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Quiz submitted!"),
                content: Text("The Quiz is submitted successfully"),
                actions: [
                  FlatButton(child: Text("Stay"),onPressed: (){
                    Navigator.pop(context);
                  },),
                  FlatButton(child: Text("Leave"),onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },)
                ],
              );
            }
          );
         },
      ),
    );
    return body;
  }
}

class DraggableAudioButton extends StatefulWidget {
  final String audioPath;
  final bool active;

  DraggableAudioButton({Key key, this.audioPath, this.active})
      : super(key: key);

  @override
  _DraggableAudioButtonState createState() =>
      _DraggableAudioButtonState(audioPath, active);
}

class _DraggableAudioButtonState extends State<DraggableAudioButton>
    with SingleTickerProviderStateMixin {
  String audioPath;
  bool playing, enabled;
  AnimationController _controller;

  _DraggableAudioButtonState(this.audioPath, this.enabled);

  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache(prefix: '');
    // try {
      print("\n\nFind the audio Path here ");
      print(audioPath);
      print("Audio path is above here!!");
    audioCache.load(audioPath); 
    // } catch (e) {
    //   print("There has been an error loading the audio file");
    // }
    playing = false;
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var aud = Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(100)),
      child: IconButton(
        disabledColor: Colors.black,
        splashColor: Color.fromARGB(29, 42, 242, 121),
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _controller,
        ),
        onPressed: (playing)
            ? null
            : (() async {
                if (!playing) {
                  setState(
                    () {
                      playing = true;
                    },
                  );
                  _controller.forward();
                  AudioPlayer audioPlayer =
                      await audioCache.play(audioPath);
                  audioPlayer.onPlayerCompletion.listen(
                    (event) {
                      setState(
                        () {
                          playing = false;
                        },
                      );
                      _controller.reverse();
                    },
                  );
                }
              }),
      ),
    );
    return Draggable<String>(
      data: audioPath,
      feedback: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              color: Color.fromARGB(20, 90, 200, 30),
              border: Border.all(width: 2, color: Colors.black45),
              borderRadius: BorderRadius.circular(100)),
          child: Icon(Icons.music_note)),
      childWhenDragging: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(40)),
      ),
      child: aud,
    );
  }
}
