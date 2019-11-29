import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> fetchData() async {
  final response = await http.get("https://1ashutosh.pythonanywhere.com/api/lessons");
  if (response.statusCode == 200) {
    String body = response.body;
    await writeData(body);
    return body;
  } else {
    // throw Exception("Unable to load!");
  }
  return "[]";
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory/
}

Future<File> get _localFile async {
  final path = await _localPath;

  return new File('$path/data.json'); //home/directory/data.txt
}

//Write and Read from our file
Future<File> writeData(String message) async {
  final file = await _localFile;

  //write to file
  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    final file = await _localFile;

    //Read
    String data = await file.readAsString();

    return data;
  } catch (e) {
    return "{}";
  }
}

Future<File> get _localFile2 async {
  final path = await _localPath;

  return new File('$path/assessment.json'); //home/directory/data.txt
}

Future<File> writeData2(String message) async {
  final file = await _localFile2;

  //write to file
  return file.writeAsString('$message');
}

Future<String> readData2() async {
  try {
    final file = await _localFile2;

    //Read
    String data = await file.readAsString();

    return data;
  } catch (e) {
    return "{}";
  }
}
