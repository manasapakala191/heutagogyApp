import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/lessons_models.dart';
import 'package:heutagogy/models/time_object_model.dart';
import 'package:video_player/video_player.dart';

class LessonViewer extends StatefulWidget {
  final Lesson lesson;
  final String lessonID, courseID,type;
  LessonViewer({this.lesson,this.lessonID,this.courseID,this.type});
  @override
  _LessonViewerState createState() => _LessonViewerState();
}

class _LessonViewerState extends State<LessonViewer> {
  Lesson lesson;

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
    _controller = VideoPlayerController.network(
      lesson.videoUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

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
      appBar: AppBar(
        title: Text(lesson.subject),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            InkWell(
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
            ),
            ListTile(
              title: Text(lesson.lessonName),
              subtitle: Text(lesson.description),
            ),
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
