import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<Assigned> assignedFromJson(String str) => List<Assigned>.from(json.decode(str).map((x) => Assigned.fromJson(x)));

String assignedToJson(List<Assigned> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Assigned {
  Assigned({
    this.id,
    this.userid,
    this.username,
    this.destinatonid,
    this.destinationname,
    this.destinationlat,
    this.destinationlong,
    this.date,
    this.imageurl,
  });

  String id;
  String userid;
  String username;
  String destinatonid;
  String destinationname;
  double destinationlat;
  double destinationlong;
  String date;
  String imageurl;

  factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(
    id: json["id"],
    userid: json["userid"],
    username: json["username"],
    destinatonid: json["destinatonid"],
    destinationname: json["destinationname"],
    destinationlat: json["destinationlat"].toDouble(),
    destinationlong: json["destinationlong"].toDouble(),
    date: json["date"],
    imageurl: json["imageurl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "username": username,
    "destinatonid": destinatonid,
    "destinationname": destinationname,
    "destinationlat": destinationlat,
    "destinationlong": destinationlong,
    "date": date,
    "imageurl": imageurl,
  };
}

Future<List<Assigned>> getPerUserAssigendList(String UserId) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  //String UserId = prefs.getString('UserId');

  //var getAssignedURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/assign/read/'+ UserId;
   //const getAssignedURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/assign/read/1';
   var getAssignedURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/assign/read/'+ UserId;
  var AssignedList = List<Assigned>();
  final response = await http.get(getAssignedURL);
  if(response.statusCode == 200)
  {
  //   Assigned.fromJson(json.decode(response.body));
    var AssignedListJsons = json.decode(response.body);
    for(var AssignedListJson in AssignedListJsons)
      {
        AssignedList.add(Assigned.fromJson(AssignedListJson));
      }
     return AssignedList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getAssignedURL)
    );
  }
}


Future<List<Assigned>> getallAssigendList() async{
  const getAssignedURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/assign/read';
  //const getAssignedURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/assign/read/1';
  var AssignedList = List<Assigned>();
  final response = await http.get(getAssignedURL);
  if(response.statusCode == 200)
  {
    //   Assigned.fromJson(json.decode(response.body));
    var AssignedListJsons = json.decode(response.body);
    for(var AssignedListJson in AssignedListJsons)
    {
      AssignedList.add(Assigned.fromJson(AssignedListJson));
    }
    return AssignedList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getAssignedURL)
    );
  }
}