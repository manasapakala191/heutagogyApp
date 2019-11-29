import 'package:flutter/material.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/tests/test2.dart';
import 'dart:convert';

import 'package:heutagogy/tests/test4.dart';
import 'package:heutagogy/tests/test7.dart';
import 'package:heutagogy/tests/test8.dart';

class Page1 extends StatelessWidget {
  Page1({Key key}) : super(key: key);
  final Test4Data test2data = Test4Data.fromJSON(json.decode(
      '{ "name": "Animal Sounds 1", "heading": "Hear the sound of the animal and match", "audios": [ { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/cat.mp3", "description": "cat" }, { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/cuckoo.mp3", "description": "cuckoo" }, { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/dog.mp3", "description": "dog" }, { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/horse.mp3", "description": "horse" }, { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/monkey.mp3", "description": "monkey" }, { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/parrot.mp3", "description": "parrot" }, { "audio": "http://1ashutosh.pythonanywhere.com/media/audio_description_pair/pig.mp3", "description": "pig" } ] }'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(),
        body: Test8Page(),
      ),
    );
  }
}
