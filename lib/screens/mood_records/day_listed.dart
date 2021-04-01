import 'package:flutter/material.dart';
import 'package:mood_daily/screens/date_tiles/day_tile.dart';
import 'package:mood_daily/models/DailyRecord.dart';
import 'package:mood_daily/services/DatabaseService.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/models/User.dart';

class DayList extends StatefulWidget {
  @override
  _DayListState createState() => _DayListState();
}

class _DayListState extends State<DayList> {

  int _size;
  var currTime;
  int _nextPageThreshold;
  bool _loading;

  @override
  void initState(){
    super.initState();
    _size = 30;
    // the current time
    currTime = new CurrentTime();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      itemCount: _size,
      itemBuilder: (context, index) {

        // get the date
        String getDate = currTime.decrementDay(index);

        return StreamBuilder(
            stream: RecordService(date: getDate, uid: user.id).getRecordData,
            builder: (context, snapshot) {
              DailyRecord localRecord = snapshot.hasData ? snapshot.data : new DailyRecord(
                  moodScore: 0, diaryText: "", date: getDate);
              return DayTile(record: localRecord);
            }
        );
      }
    );
  }
}
