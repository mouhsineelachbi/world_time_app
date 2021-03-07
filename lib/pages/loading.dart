import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getTime() async{

    // Make the request
    Response response = await get('https://worldtimeapi.org/api/timezone/Africa/Casablanca');
    Map data = jsonDecode(response.body);
    //  print(data);

    //  Get properties from data
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    // print(dateTime);
    // print(offset);

    //  Create a dateTime object
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    print(now);

  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Loading sceene'),
    );
  }
}
