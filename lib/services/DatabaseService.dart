import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_daily/models/DailyRecord.dart';
import 'package:mood_daily/models/MonthlyScore.dart';
import 'package:mood_daily/models/YearlyRecord.dart';


class RecordService{

  final String date;
  final String uid;

  RecordService({this.date, this.uid});

  // users collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  // get the document of the current user
  DocumentReference getUser(){
    return userCollection.document(uid);
  }

  // convert from snapshot to DailyRecord
  DailyRecord _recordFromSnapshot(DocumentSnapshot snap){
    return DailyRecord(
      date: date,
      diaryText: snap.data['diaryText'],
      moodScore: snap.data['moodScore'],
    );
  }

  // get the data of a specific date
  Stream<DailyRecord> get getRecordData{
    return getUser().collection('daily_records').document(date).snapshots().map(_recordFromSnapshot);
  }


  // set the mood score
  Future setMoodScore(int moodScore) async {
    return await getUser().collection('daily_records').document(date).setData({
      'moodScore': moodScore,
      'date': date,
    });
  }

  // set the daily diary
  Future setDiary(String text) async {
    return await getUser().collection('daily_records').document(date).updateData({
      'diaryText': text,
    });
  }

}



class MonthService{

  final String date;
  final String uid;

  MonthService({this.date, this.uid});

  // users collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  // get the document of the current user
  DocumentReference getUser(){
    return userCollection.document(uid);
  }

  // convert from snapshot to MonthlyScore
  MonthlyScore _recordFromMonthSnapshot(DocumentSnapshot snap){
    return MonthlyScore(
      moodScore: snap.data['moodScore'],
      totalRecords: snap.data['totalRecords'],
      year: snap.data['year'],
      month: snap.data['month'],
    );
  }

  // get the monthly data of a specific month
  Stream<MonthlyScore> get getMonthlyData{
    return getUser().collection('months').document(date).snapshots().map(_recordFromMonthSnapshot);
  }

  // set the monthly data
  Future updateMonthlyData(int moodScore, int totalRecords, int month, int year) async {
    return await getUser().collection('months').document(date).setData({
      'moodScore': moodScore,
      'totalRecords': totalRecords,
      'month': month,
      'year': year,
    });
  }
}



class YearService{

  final String date;
  final String uid;

  YearService({this.date, this.uid});

  // users collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  // get the document of the current user
  DocumentReference getUser(){
    return userCollection.document(uid);
  }

  // convert from snapshot to MonthlyScore
  YearlyRecord _recordFromSnapshot(DocumentSnapshot snap){
    return YearlyRecord(
      moodScore: snap.data['moodScore'],
      totalRecords: snap.data['totalRecords'],
      year: snap.data['year'],
    );
  }

  // get the monthly data of a specific month
  Stream<YearlyRecord> get getData{
    return getUser().collection('months').document(date).snapshots().map(_recordFromSnapshot);
  }

  // set the monthly data
  Future updateMonthlyData(int moodScore, int totalRecords, int year) async {
    return await getUser().collection('months').document(date).setData({
      'moodScore': moodScore,
      'totalRecords': totalRecords,
      'year': year,
    });
  }
}