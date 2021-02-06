import 'package:flutter/material.dart';
import 'package:heutagogy/services/downloadFunctions.dart';

class DisplayJsonScreen extends StatelessWidget {
  String cid;
  DisplayJsonScreen(this.cid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: DownloadService.readJson(cid),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text("There's an error");
            }
            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasData){
                var json = snapshot.data;
                return Center(
                  child: Container(
                    height: 500,
                    margin: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(json.toString()),
                    ),
                  ),
                );
              }

            }
            return CircularProgressIndicator();
          }
        ),
    );
  }
}
