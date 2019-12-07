import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/data_models.dart';

class Test4Page extends StatefulWidget {
  final Test4Data test4data;

  Test4Page(this.test4data, {Key key}) : super(key: key);

  @override
  _Test4PageState createState() => _Test4PageState(test4data);
}

class _Test4PageState extends State<Test4Page> {
  Test4Data test4data;
  var correct;
  var seed;

  _Test4PageState(Test4Data data) {
    seed = Random().nextInt(100);
    this.test4data = data;
    this.correct = Map();
    for (var audio in this.test4data.audios) {
      correct[audio.description] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        (test4data.heading == null || test4data.heading == "")
            ? Container()
            : Center(
                child: Text(
                test4data.heading,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        Padding(padding: EdgeInsets.only(top: 20),),
        Column(
          children: _builder(test4data, correct, seed),
        ),
      ]),
    );
  }

  List<Widget> _builder(Test4Data test4data, Map correct, var seed) {
    List<Widget> body = [];
    List<Widget> drops = [];
    List<Widget> targets = [];

    for (var sound in test4data.audios) {
      if (correct[sound.description]) {
        drops.add(Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: Color.fromARGB(20, 10, 240, 34),
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 32,
            )));
      } else {
        drops.add(
            DraggableAudioButton(audioPath: sound.description, active: correct[sound.description]));
      }
      targets.add(
        DragTarget(
          builder: (BuildContext context, List<String> incoming, List rejected) {
            if (!correct[sound.description]) {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 64,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.lightBlue, width: 2),
                      color: Colors.blueAccent),
                  padding: EdgeInsets.all(10),
                  height: 64,
                  child: Center(
                      child: Text(
                    sound.description,
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(bottom: 4),
                width: 140,
                height: 64,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.greenAccent, width: 2),
                        color: Colors.green),
                    padding: EdgeInsets.all(10),
                    height: 64,
                    child: Center(
                      child: Text(
                        "Correct",
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              );
            }
          },
          onAccept: (data) {
            setState(() {
              correct[sound.description] = true;
            });
          },
          onLeave: (data) {},
          onWillAccept: (data) => data == sound.description,
        ),
      );
    }
    targets..shuffle(Random(seed));
    for (int i = 0; i < test4data.audios.length; i++) {
      body.add(Padding(
          padding: EdgeInsets.only(top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[drops[i], targets[i]],
          )));
    }
    return body;
  }
}

class DraggableAudioButton extends StatefulWidget {
  final String audioPath;
  final bool active;

  DraggableAudioButton({Key key, this.audioPath, this.active}) : super(key: key);

  @override
  _DraggableAudioButtonState createState() => _DraggableAudioButtonState(audioPath, active);
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
    audioCache = AudioCache(prefix: 'audio/');
    audioCache.load("$audioPath.mp3");
    playing = false;
    _controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
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
      decoration:
          BoxDecoration(border: Border.all(width: 2), borderRadius: BorderRadius.circular(100)),
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
                  setState(() {
                    playing = true;
                  });
                  _controller.forward();
                  AudioPlayer audioPlayer = await audioCache.play("$audioPath.mp3");
                  audioPlayer.onPlayerCompletion.listen((event) {
                    setState(() {
                      playing = false;
                    });
                    _controller.reverse();
                  });
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
        child: aud);
  }
}
