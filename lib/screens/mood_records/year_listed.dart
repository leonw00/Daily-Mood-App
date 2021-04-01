import 'package:flutter/material.dart';
import 'package:mood_daily/screens/date_tiles/year_tile.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:mood_daily/services/DatabaseService.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/models/User.dart';
import 'package:mood_daily/models/YearlyRecord.dart';

class YearList extends StatefulWidget {
  @override
  _YearListState createState() => _YearListState();
}

class _YearListState extends State<YearList> {

  // The current time
  var currTime = new CurrentTime();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          // get the current year
          int currYear = currTime.getYear - index;
          return StreamBuilder(
              stream: YearService(date: currYear.toString(), uid: user.id).getData,
              builder: (context, snapshot) {
                YearlyRecord localRecord = snapshot.hasData ? snapshot.data : new YearlyRecord(totalRecords: 0, moodScore: 0, year: currYear);
                return YearTile(data: localRecord);
              }
          );
        }
    );
  }
}
