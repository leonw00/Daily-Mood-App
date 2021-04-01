import 'package:flutter/material.dart';
import 'package:mood_daily/screens/day_content.dart';
import 'package:mood_daily/services/DatabaseService.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/models/User.dart';

class DayPage extends StatefulWidget {

  final String date;

  DayPage({this.date});

  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {

  @override
  Widget build(BuildContext context) {

    // set the current time according to the date
    CurrentTime().setTime(widget.date);

    // get the date
    String getDate = widget.date;

    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        elevation: 0,
        title: Text("$getDate"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: RecordService(date: getDate, uid: user.id).getRecordData,
        builder: (context, snapshot){
          return DayContent(data: snapshot.data);
        }
      ),
    );
  }
}
