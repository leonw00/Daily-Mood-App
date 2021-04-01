import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mood_daily/services/DatabaseService.dart';
import 'package:mood_daily/shared/curr_time.dart';
import 'package:provider/provider.dart';
import 'package:mood_daily/models/User.dart';

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {

  final textController = TextEditingController();

  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              // *************
              //    TEXT
              // *************
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: Text(
                  'Write down your feelings',
                  style: TextStyle(
                    fontSize: 47,
                    color: Colors.grey[200],
                  ),
                ),
              ),

              SizedBox(height: 40,),
              // *************
              //   TextField
              // *************
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter anything...',
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 18,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300]
                  ),
                ),
              ),


              SizedBox(height: 40,),
              // *************
              // Record Button
              // *************
              FlatButton(
                onPressed: () async {
                  // store the text to the database
                  await RecordService(date: CurrentTime().getDate, uid: user.id).setDiary(textController.text);
                  // destroy the current screen
                  Navigator.pop(context);
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
      ),
    );
  }
}
