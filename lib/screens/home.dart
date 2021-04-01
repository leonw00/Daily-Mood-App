import 'package:flutter/material.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:mood_daily/services/Auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  final now = CurrentTime();

  // mood button toggle
  bool canRecord = true;
  IconData boxIcon = Icons.check_box_outline_blank;

  @override
  void initState(){
    super.initState();
    anonymousSignIn();
  }

  // by default, sign in anonymously
  void anonymousSignIn() async{
    try{
      dynamic result = await _auth.signInAnon();
      print(result);
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {

    var curTime = now.getHour;
    var formattedDate = now.getDate;

    return Scaffold(
      backgroundColor: Colors.blue[curTime > 6 && curTime < 18 ? 200 : 700],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 120,),
            // *************
            //    The Date
            // *************
            Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  left: -10,
                  top: -60,
                  child: Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 150,
                  ),
                ),
                Positioned(
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 20,
                  child: Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 120,
                  ),
                ),
              ]
            ),
            SizedBox(height: 155,),


            // *************************
            // Button for Mood Daily
            // *************************
            FlatButton.icon(
              icon: Icon(
                boxIcon,
                size: 35,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.grey[200],
              minWidth: 250,
              height: 60,
              onPressed: () async {
                if(canRecord) {
                  dynamic result = await Navigator.pushNamed(context, '/mood');
                  setState(() {
                    canRecord = result['recordState'];
                    boxIcon = result['icon'];
                  });
                }
              },
              label: Text(
                'Daily Mood',
                style: TextStyle(
                    fontSize: 28
                ),
              ),
            ),
            SizedBox(height: 28,),


            // *************************
            // Button for Review Tracker Records of Moods
            // *************************
            FlatButton.icon(
              icon: Icon(
                Icons.date_range_outlined,
                size: 35,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.grey[200],
              minWidth: 250,
              height: 60,
              onPressed: (){
                Navigator.pushNamed(context, '/date');
              },
              label: Text(
                'Tracked',
                style: TextStyle(
                    fontSize: 28
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

