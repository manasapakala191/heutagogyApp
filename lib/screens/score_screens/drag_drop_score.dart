import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class DragDropScoreWidget extends StatefulWidget {
  final Progress progress;
  final DragDropAudioTest questionTest;

  DragDropScoreWidget({this.progress, this.questionTest});

  @override
  _DragDropScoreWidgetState createState() => _DragDropScoreWidgetState();
}

class _DragDropScoreWidgetState extends State<DragDropScoreWidget> {

  List<Widget> _buildChildren(){
    List<Widget> children = List<Widget>();
    for(int i = 0; i < widget.questionTest.audios.length; i ++){
      children.add(
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AudioQuestionResponseViewer(
            response: widget.progress.responses[i],
            questionData: widget.questionTest.audios[i],
          ),
        )
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.questionTest.subject,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            SlideHeader(
              testName: widget.questionTest.testName,
              testDescription: widget.questionTest.testDescription,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChartWidget(
                wrong: widget.progress.total - widget.progress.partsDone,
                right: widget.progress.partsDone,
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
                      Text("Correct",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),),
                      Text("Response",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),)
                    ]
                  ),
              ),
            ),
            Column(
              children: _buildChildren(),
            )
          ],
        ),
      ),
    );
  }
}

class AudioQuestionResponseViewer extends StatelessWidget {
  final AudioPair questionData;
  final String response;

  AudioQuestionResponseViewer({this.questionData, this.response});

  @override
  Widget build(BuildContext context) {
    print("hhjbfjsbfja--------");
    print(response);
    print(questionData.description);
    return Card(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          response == questionData.description ? Icon(Icons.check,color:Colors.green): Icon(Icons.clear,color:Colors.red),
          AudioButton(active: false,audioPath: questionData.description,),
          Text(questionData.description),
          Text(response == null ? "-":response)
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
