import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/lessons_models.dart';
import 'package:heutagogy/models/time_object_model.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonViewer extends StatefulWidget {
  final Lesson lesson;
  final String lessonID, courseID,type;
  final String videoURL;
  LessonViewer({this.lesson,this.lessonID,this.courseID,this.type,this.videoURL});
  @override
  _LessonViewerState createState() => _LessonViewerState();
}

class _LessonViewerState extends State<LessonViewer> {
  Lesson lesson;
  String videoUrl;
  final timeObject = TimeObject(
      screen: 'Lessons Screen',
      courseId: 'Default Course ID',
      testId: 'Default Test ID');

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool showControllerButtons = true;


  YoutubePlayerController _controller1;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool _isYoutube=false;
  @override
  void initState() {
    lesson = widget.lesson;
    timeObject.setStartTime(DateTime.now());
    videoUrl=widget.videoURL;
    _isYoutube = videoUrl.contains("youtube");
    print("me"+videoUrl);
    print("boolYT"+_isYoutube.toString());
    if(_isYoutube){
      youTubePlayerInitializer();
    } else {
      playerInitializer();
    }
    super.initState();
  }

  playerInitializer(){
    _controller = VideoPlayerController.network(
      videoUrl,
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  youTubePlayerInitializer(){
    var id = YoutubePlayer.convertUrlToId(
        videoUrl
    );
    _controller1 = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller1.value.isFullScreen) {
      setState(() {
        _playerState = _controller1.value.playerState;
        _videoMetaData = _controller1.metadata;
      });
    }
  }

  @override
  void dispose() {
    timeObject.setEndTime(DateTime.now());
    timeObject.addTimeObjectToStudentPerformance();
    if(_isYoutube){
    _controller.dispose();}
    else{
    _controller1.dispose();}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    return Scaffold(
      appBar: CustomAppBar(title: lesson.subject,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            SlideHeader(
              testName: lesson.lessonName,
              testDescription: lesson.description,
            ),
            Padding(padding: EdgeInsets.all(10)),
            _isYoutube? YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller1,
                  showVideoProgressIndicator: true,
                  onReady: () {
            _isPlayerReady = true;
            },
                ),
              builder: (context,player) => Container(
                child: player,
              ),
            ):
            videoUrl!=null? videoUrl.isNotEmpty? InkWell(
              onTap: () {
                setState(
                  () {
                    showControllerButtons = !showControllerButtons;
                  },
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(7),
                    height: MediaQuery.of(context).size.height / 3,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print("Connection established!");
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller,),
                          );
                        }
                        print("After if block");
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  showControllerButtons
                      ? Positioned(
                          height: 100,
                          top: MediaQuery.of(context).size.height / 10,
                          child: ButtonBar(
                            children: [
                              FloatingActionButton(
                                child: Icon(_controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                onPressed: () {
                                  setState(
                                    () {
                                      if (_controller.value.isPlaying) {
                                        setState(
                                          () {
                                            _controller.pause();
                                          },
                                        );
                                      } else {
                                        setState(
                                          () {
                                            _controller.play();
                                          },
                                        );
                                      }
                                    },
                                  );
                                },
                                mini: true,
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ): Container() : Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Text(lesson.lessonContent),
            )
          ],
        ),
      ),
    );
  }
}
