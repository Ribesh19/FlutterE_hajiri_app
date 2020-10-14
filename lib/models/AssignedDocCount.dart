import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AssignedCount {
  String collection;
  int doccount;

  AssignedCount({this.collection, this.doccount});

  AssignedCount.fromJson(Map<String, dynamic> json) {
    collection = json['collection'];
    doccount = json['doccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection'] = this.collection;
    data['doccount'] = this.doccount;
    return data;
  }
}

Future<List<AssignedCount>> getAssignedDocCountList() async{
  //const getAssignedDocCountURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/assign/readcount';
  //const getAssignedDocCountURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/assign/readcount';
  const getAssignedDocCountURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/assign/readcount';
  var AssignedCountList = List<AssignedCount>();
  final response = await http.get(getAssignedDocCountURL);
  if(response.statusCode == 200)
  {
    //   Assigned.fromJson(json.decode(response.body));
    var AssignedCountListJsons = json.decode(response.body);
    for(var AssignedListJson in AssignedCountListJsons)
    {
      AssignedCountList.add(AssignedCount.fromJson(AssignedListJson));
    }
    return AssignedCountList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getAssignedDocCountURL)
    );
  }
}