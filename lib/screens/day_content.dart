import 'package:flutter/material.dart';
import 'package:mood_daily/models/DailyRecord.dart';

class DayContent extends StatelessWidget {

  final DailyRecord data;

  DayContent({this.data});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image(
                image: AssetImage('assets/face${data.moodScore}.png'),
                width: 100,
                height: 100,
                color: Colors.grey[100],
              ),
              SizedBox(height: 35,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  '${data.diaryText}',
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),);
  }
}
