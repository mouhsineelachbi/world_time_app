import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //  location name for the UI
  String time; // Time in that location
  String flag;  //  url to the asset flag icon
  String url; //  location url for the api endpoint
  bool isDaytime; // true of false if It's daytime or not

  WorldTime({this.location, this.flag, this.url});

  void getTime() async {

    try {
      //  Make the request
      Response response = await get("https://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      //  Get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //  Create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      // verify if It's daytime or not
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      //  Set the time property
      time = DateFormat.jm().format(now);

    } catch(e) {
      print('Caught an error : $e');
      time = 'Couldn\'t get time data';
    }
  }
}