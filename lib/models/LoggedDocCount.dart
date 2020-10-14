import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';


// To parse this JSON data, do
//
//     final loggedCount = loggedCountFromJson(jsonString);
List<LoggedCount> loggedCountFromJson(String str) => List<LoggedCount>.from(json.decode(str).map((x) => LoggedCount.fromJson(x)));

String loggedCountToJson(List<LoggedCount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@JsonSerializable()
class LoggedCount {
  LoggedCount({
    this.collection,
    this.doccount,
  });

  String collection;
  int doccount;

  factory LoggedCount.fromJson(Map<String, dynamic> json) => LoggedCount(
    collection: json["collection"],
    doccount: json["doccount"],
  );

  Map<String, dynamic> toJson() => {
    "collection": collection,
    "doccount": doccount,
  };
}


Future<List<LoggedCount>> getLoggedDocCountList() async{
  //const getAssignedDocCountURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/assign/readcount';

  //const getLoggedDocCountURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/logged/readcount/';
  const getLoggedDocCountURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/logged/readcount/';
  var LoggedCountList = List<LoggedCount>();
  final response = await http.get(getLoggedDocCountURL);
  if(response.statusCode == 200)
  {
    //   Assigned.fromJson(json.decode(response.body));
    var LoggedCountListJsons = json.decode(response.body);
    for(var LoggedListJson in LoggedCountListJsons)
    {
      LoggedCountList.add(LoggedCount.fromJson(LoggedListJson));
    }
    return LoggedCountList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getLoggedDocCountURL)
    );
  }
}
