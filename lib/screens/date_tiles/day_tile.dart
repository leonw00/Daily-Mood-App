import 'package:flutter/material.dart';
import 'package:mood_daily/models/DailyRecord.dart';
import 'package:mood_daily/screens/day_page.dart';

class DayTile extends StatelessWidget {

  final DailyRecord record;

  DayTile({this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: (){
          if(record.moodScore > 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayPage(date: record.date),
                )
            );
          }
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Image(
                image: AssetImage('assets/face' + record.moodScore.toString() + '.png'),
                width: 50,
                height: 50,
                color: Colors.blue[700],
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  record.date,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
