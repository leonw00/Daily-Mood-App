import 'package:flutter/material.dart';
import 'package:mood_daily/screens/mood_records/day_listed.dart';
import 'package:mood_daily/screens/mood_records/month_listed.dart';

class DateTemplate extends StatefulWidget {
  @override
  _DateTemplateState createState() => _DateTemplateState();
}

class _DateTemplateState extends State<DateTemplate> {

  // Displaying the default
  Widget currentList = MonthList();

  List<Color> appBarColors = [Colors.blue[900], Colors.blue[300]];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.purple[500],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 30,
          width: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: () {
                  if(currentList is !MonthList) {
                    setState(() {
                      appBarColors =
                      [Colors.purple[500], Colors.blue[300]];
                      currentList = MonthList();
                    });
                  }
                },
                child: Text('Month', style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: appBarColors[0],
                minWidth: 70,
              ),
              FlatButton(
                onPressed: () {
                  if(currentList is !DayList) {
                    setState(() {
                      appBarColors =
                      [Colors.blue[300], Colors.purple[500]];
                      currentList = DayList();
                    });
                  }
                },
                child: Text('Day', style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: appBarColors[1],
                minWidth: 70,
              ),
            ],
          ),
        ),
      ),


      body: Center(
        child: currentList,
      ),

    );
  }
}
