import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/lessons_models.dart';
import 'package:heutagogy/models/time_object_model.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/handyWidgets/slideHeading.dart';
import 'package:video_player/video_player.dart';

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

  @override
  void initState() {
    lesson = widget.lesson;
    timeObject.setStartTime(DateTime.now());
    videoUrl=widget.videoURL;
    print(widget.videoURL);
    _controller = VideoPlayerController.network(
      videoUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }
  //
  // _initializeVideoPlayerFuture(){
  //
  // }

  @override
  void dispose() {
    timeObject.setEndTime(DateTime.now());
    timeObject.addTimeObjectToStudentPerformance();
    _controller.dispose();
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
                            child: VideoPlayer(_controller),
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
