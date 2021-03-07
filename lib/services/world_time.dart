import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location; //  location name for the UI
  String time; // Time in that location
  String flag;  //  url to the asset flag icon
  String url; //  location url for the api endpoint

  WorldTime({this.location, this.flag, this.url});

  void getTime() async {

    try {
      //  Make the request
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      //  Get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //  Create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      //  Set the time property
      time = now.toString();

    } catch(e) {
      print('Caught an error : $e');
      time = 'Couldn\'t get time data';
    }
  }
}