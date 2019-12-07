import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class StarTest extends StatefulWidget {
  final String heading;

  StarTest(this.heading, {Key key}) : super(key: key);

  @override
  _StarTestState createState() => _StarTestState(heading);
}

class _StarTestState extends State<StarTest> {
  String heading;
  double rating;

  _StarTestState(this.heading);

  @override
  void initState() {
    super.initState();
    rating = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            child: Center(
              child: Text(
                heading,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 20),
          ),
          SmoothStarRating(
              allowHalfRating: false,
              onRatingChanged: (v) {
                rating = v;
                setState(() {});
              },
              starCount: 3,
              rating: rating,
              size: 40.0,
              color: Colors.green,
              borderColor: Colors.green,
              spacing: 0.0)
        ],
      ),
    );
  }
}
