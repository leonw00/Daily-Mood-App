import 'package:flutter/material.dart';
import 'package:mood_daily/models/User.dart';
import 'package:mood_daily/screens/home.dart';
import 'package:mood_daily/screens/moodfacepage.dart';
import 'package:mood_daily/screens/textpage.dart';
import 'package:mood_daily/screens/day_page.dart';
import 'package:mood_daily/screens/mood_records/date_template.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/services/Auth.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context)=>Home(),
          '/mood':(context)=>MoodFace(),
          '/text':(context)=>TextPage(),
          '/date':(context)=>DateTemplate(),
          '/dayPage': (context)=>DayPage(),
        },
      ),
    );
  }
}
