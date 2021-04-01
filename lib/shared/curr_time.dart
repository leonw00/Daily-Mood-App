import 'package:intl/intl.dart';

class CurrentTime{

  DateTime _now;
  final List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  CurrentTime(){
    _now = new DateTime.now();
  }

  String get getDate{
    return DateFormat('MMM dd, yyyy').format(_now);
  }

  int get getHour{
    return _now.hour;
  }

  int get getYear{
    return _now.year;
  }

  int get getMonth{
    return _now.month;
  }

  String decrementDay(int d){
    DateTime newDate = DateTime(_now.year, _now.month, _now.day - d);
    return DateFormat('MMM dd, yyyy').format(newDate);
  }

  String incrementDay(int d){
    DateTime newDate = DateTime(_now.year, _now.month, _now.day + d);
    return DateFormat('MMM dd, yyyy').format(newDate);
  }

  DateTime decrementMonth(int m){
    return DateTime(_now.year, _now.month - m, _now.day);
  }

  void setTime(String currTime){
    String monthString = currTime.substring(0,3);
    int month = months.indexOf(monthString) + 1;
    int day = int.parse(currTime.substring(4,6));
    int year = int.parse(currTime.substring(8,12));
    _now = DateTime(year, month, day);
  }

}