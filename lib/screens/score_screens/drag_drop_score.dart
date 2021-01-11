import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class DragDropScoreWidget extends StatefulWidget {
  final Map<String,dynamic> responseMap;
  final DragDropAudioTest questionTest;

  DragDropScoreWidget({this.responseMap, this.questionTest});

  @override
  _DragDropScoreWidgetState createState() => _DragDropScoreWidgetState();
}

class _DragDropScoreWidgetState extends State<DragDropScoreWidget> {
  int wrong = 0, right = 0;

  void evaluateAnswers(){
    for(var key in widget.responseMap.keys){
      if(key == widget.responseMap[key]){
        right++;
      }
      else{
        wrong++;
      }
    }
  }
  @override
  void initState(){
    super.initState();
    evaluateAnswers();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Your score in " + widget.questionTest.testName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            ListTile(
              title: Text(widget.questionTest.testName),
              subtitle: Text(widget.questionTest.testDescription),
              trailing: Text(widget.questionTest.subject),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChartWidget(
                wrong: wrong,
                right: right,
              ),
            ),
            ListTile(
              title: Text('Responses',style: GoogleFonts.varelaRound(fontSize: 20),),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Acceptance",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white, ),),
                      Text("Audio",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),),
                      Text("Correct choice",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),),
                      Text("Chosen choice",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),)
                    ]
                  ),
              ),
            ),
            Column(
              children: widget.questionTest.audios.map((e) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AudioQuestionResponseViewer(
                  responseMap: widget.responseMap,
                  questionData: e,
                ),
              )).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class AudioQuestionResponseViewer extends StatelessWidget {
  final AudioPair questionData;
  final Map<String, dynamic> responseMap;

  AudioQuestionResponseViewer({this.questionData, this.responseMap});

  @override
  Widget build(BuildContext context) {
    print("hhjbfjsbfja--------");
    print(responseMap);
    print(questionData.description);
    return Card(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          responseMap[questionData.description] == questionData.description ? Icon(Icons.check,color:Colors.green): Icon(Icons.clear,color:Colors.red),
          AudioButton(active: false,audioPath: questionData.description,),
          Text(questionData.description),
          Text(responseMap[questionData.description] == null ? "-":responseMap[questionData.description])
        ],
      ),
    );
  }
}

class AudioButton extends StatefulWidget {
  final String audioPath;
  final bool active;

  AudioButton({Key key, this.audioPath, this.active})
      : super(key: key);

  @override
  _AudioButtonState createState() =>
      _AudioButtonState(audioPath, active);
}

class _AudioButtonState extends State<AudioButton>
    with SingleTickerProviderStateMixin {
  String audioPath;
  bool playing, enabled;
  AnimationController _controller;

  _AudioButtonState(this.audioPath, this.enabled);

  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache(prefix: 'assets/audios/');
    // try {
      print("\n\nFind the audio Path here ");
      print(audioPath);
      print("Audio path is above here!!");
    audioCache.load("$audioPath.mp3"); 
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
      width: 43,
      height: 43,
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
                      await audioCache.play("$audioPath.mp3");
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
    return Container(
      padding: EdgeInsets.all(15),
      child: aud,
    );
  }
}
