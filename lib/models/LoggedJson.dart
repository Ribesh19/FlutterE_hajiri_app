import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';


// To parse this JSON data, do
//
//     final logged = loggedFromJson(jsonString);

import 'dart:convert';

List<Logged> loggedFromJson(String str) => List<Logged>.from(json.decode(str).map((x) => Logged.fromJson(x)));

String loggedToJson(List<Logged> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Logged {
  Logged({
    this.id,
    this.userid,
    this.username,
    this.destinatonid,
    this.destinationname,
    this.destinatonlat,
    this.destinatonlong,
    this.loggedlat,
    this.loggedlong,
    this.loggeddist,
    this.loggeddate,
  });

  String id;
  String userid;
  String username;
  String destinatonid;
  String destinationname;
  double destinatonlat;
  double destinatonlong;
  double loggedlat;
  double loggedlong;
  double loggeddist;
  String loggeddate;

  factory Logged.fromJson(Map<String, dynamic> json) => Logged(
    id: json["id"],
    userid: json["userid"],
    username: json["username"],
    destinatonid: json["destinatonid"],
    destinationname: json["destinationname"],
    destinatonlat: json["destinatonlat"].toDouble(),
    destinatonlong: json["destinatonlong"].toDouble(),
    loggedlat: json["loggedlat"].toDouble(),
    loggedlong: json["loggedlong"].toDouble(),
    loggeddist: json["loggeddist"].toDouble(),
    loggeddate: json["loggeddate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "username": username,
    "destinatonid": destinatonid,
    "destinationname": destinationname,
    "destinatonlat": destinatonlat,
    "destinatonlong": destinatonlong,
    "loggedlat": loggedlat,
    "loggedlong": loggedlong,
    "loggeddist": loggeddist,
    "loggeddate": loggeddate,
  };
}

Future<List<Logged>> getallLoggedList() async{

  //const getLoggedURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/logged/read';
  const getLoggedURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/logged/read';
  //const getAssignedURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/assign/read/1';
  var LoggedList = List<Logged>();
  final response = await http.get(getLoggedURL);
  if(response.statusCode == 200)
  {
    //   Assigned.fromJson(json.decode(response.body));
    var LoggedListJsons = json.decode(response.body);
    for(var LoggedListJson in LoggedListJsons)
    {
      LoggedList.add(Logged.fromJson(LoggedListJson));
    }
    return LoggedList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getLoggedURL)
    );
  }
}
