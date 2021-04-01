import 'package:flutter/material.dart';
import 'package:mood_daily/models/MonthlyScore.dart';
import 'package:mood_daily/screens/date_tiles/month_tile.dart';
import 'package:mood_daily/services/DatabaseService.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/models/User.dart';

class MonthList extends StatefulWidget {
  @override
  _MonthListState createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {

  // The current time
  var currTime = new CurrentTime();


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return GridView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        addRepaintBoundaries: false,
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          // get the date
          DateTime newTime = currTime.decrementMonth(index);
          // get the month year format
          String monthOf = newTime.month.toString() + " " + newTime.year.toString();
          return StreamBuilder(
              stream: MonthService(date: monthOf, uid: user.id).getMonthlyData,
              builder: (context, snapshot) {
                MonthlyScore localRecord = snapshot.hasData ? snapshot.data : new MonthlyScore(totalRecords: 0, moodScore: 0, month: newTime.month, year: newTime.year);
                return MonthTile(data: localRecord);
              }
          );
        }
    );

  }
}

