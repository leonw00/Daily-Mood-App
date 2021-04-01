import 'package:flutter/material.dart';
import 'package:mood_daily/models/MonthlyScore.dart';

class MonthTile extends StatelessWidget {

  final MonthlyScore data;

  MonthTile({this.data});

  final List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  final List totalDays = ['31', '28', '31', '30', '31', '30', '31', '31', '30', '31', '30', '31'];


  @override
  Widget build(BuildContext context) {
    // the face image of the month
    var faceImage = data.totalRecords > 0 ? data.moodScore ~/ data.totalRecords : 0;

    return GestureDetector(
      onTap: (){

      },
      child: Card(
        margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
        child: GridTile(
          header: Center(
            child: Text(
              data.totalRecords.toString() + '/' + totalDays[data.month - 1] + ' Recorded',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500]
              ),
            ),
          ),
          child: Center(
            child: Image(
              image: AssetImage('assets/face' + faceImage.toString() + '.png'),
              width: 75,
              height: 75,
              color: Colors.blue[700],
            ),
          ),
          footer: Center(
            child: Text(
              '${months[data.month - 1]} ${data.year}',
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
