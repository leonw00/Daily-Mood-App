import 'package:flutter/material.dart';
import 'package:mood_daily/services/DatabaseService.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/models/User.dart';

class MoodFace extends StatefulWidget {
  @override
  _MoodFaceState createState() => _MoodFaceState();
}

class _MoodFaceState extends State<MoodFace> {

  // values
  int _curMoodVal = 4;

  @override
  Widget build(BuildContext context) {

    // get the current time
    CurrentTime time = new CurrentTime();
    // the current month year
    String monthOf = time.getMonth.toString() + " " + time.getYear.toString();

    final user = Provider.of<User>(context);

    return StreamBuilder(
      stream: MonthService(date: monthOf, uid: user.id).getMonthlyData,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.blue[400],
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                // *************
                //    TEXT
                // *************
                Text(
                  'How are you today?',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey[200],
                  ),
                ),


                SizedBox(height: 70,),
                // *************
                //    Image
                // *************
                Image(
                  image: AssetImage(
                      'assets/face' + _curMoodVal.toString() + '.png'),
                  width: 250,
                  height: 250,
                  color: Colors.grey[200],
                ),


                SizedBox(height: 40,),
                // *************
                //    Slider
                // *************
                Slider(
                  min: 1,
                  max: 7,
                  value: _curMoodVal.toDouble(),
                  onChanged: (val) {
                    setState(() {
                      _curMoodVal = val.round();
                    });
                  },
                  inactiveColor: Colors.grey[400],
                  activeColor: Colors.grey[300],
                ),


                SizedBox(height: 30,),
                // *************
                //  Record Button
                // *************
                FlatButton(
                  onPressed: () async {
                    // store the score to the database
                    await RecordService(date: time.getDate, uid: user.id).setMoodScore(_curMoodVal);
                    // store the monthly data to the database
                    int score = snapshot.hasData ? snapshot.data.moodScore : 0;
                    int totalRecords = snapshot.hasData ? snapshot.data.totalRecords : 0;
                    await MonthService(date: monthOf, uid: user.id).updateMonthlyData(score + _curMoodVal, totalRecords + 1, time.getMonth, time.getYear);
                    // pop the current screen and transfer some data back
                    Navigator.pop(context, {
                      'recordState': false,
                      'icon': Icons.check_box_outlined,
                    });
                    // go to the next page
                    Navigator.pushNamed(context, '/text');
                  },
                  child: Text(
                    'RECORD',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.purple[400],
                  minWidth: 200,
                  height: 50,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
