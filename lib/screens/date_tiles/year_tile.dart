import 'package:flutter/material.dart';
import 'package:mood_daily/models/YearlyRecord.dart';

class YearTile extends StatelessWidget {

  final YearlyRecord data;

  YearTile({this.data});

  @override
  Widget build(BuildContext context) {

    // determine leap year
    int isLeap = data.year % 4 == 0 ? 366 : 365;

    // determine the face score
    int faceScore = data.totalRecords > 0 ? data.moodScore ~/ data.totalRecords : 0;

    return GestureDetector(
      onTap: (){

      },
      child: Card(
        margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
        child: GridTile(
          header: Center(
            child: Text(
              '${data.totalRecords}/$isLeap Recorded',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500]
              ),
            ),
          ),
          child: Center(
            child: Image(
              image: AssetImage('assets/face$faceScore.png'),
              width: 75,
              height: 75,
              color: Colors.blue[700],
            ),
          ),
          footer: Center(
            child: Text(
              '${data.year}',
              style: TextStyle(
                  fontSize: 24
              ),
            ),
          ),
        ),
      ),
    );
  }
}
