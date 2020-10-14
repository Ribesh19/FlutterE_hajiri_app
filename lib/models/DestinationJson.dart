import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Destinations {
  String id;
  String title;
  String address;
  double latitude;
  double longitude;
  String imageurl;

  Destinations(
      {this.id,
        this.title,
        this.address,
        this.latitude,
        this.longitude,
        this.imageurl});

  Destinations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['imageurl'] = this.imageurl;
    return data;
  }
}

Future<List<Destinations>> getAllDestinations() async{
  //const getAllDestinationURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/destinations/read/';

  //const getAllDestinationURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/destinations/read/';
  const getAllDestinationURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/destinations/read/';
  var DestinationList = List<Destinations>();
  final response = await http.get(getAllDestinationURL);
  if(response.statusCode == 200)
  {
    //   Assigned.fromJson(json.decode(response.body));
    var DestinationListJsons = json.decode(response.body);
    for(var DestinationListJson in DestinationListJsons)
    {
      DestinationList.add(Destinations.fromJson(DestinationListJson));
    }
    return DestinationList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getAllDestinationURL)
    );
  }
}