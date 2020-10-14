import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Users {
  String id;
  String name;
  String address;
  int phoneno;
  String email;

  Users({this.id, this.name, this.address, this.phoneno, this.email});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phoneno = json['phoneno'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phoneno'] = this.phoneno;
    data['email'] = this.email;
    return data;
  }
}

Future<List<Users>> getAllusersList() async{

  //const getAssignedURL = 'http://10.0.2.2:5001/e-hajiree/us-central1/app/api/user/read/';
  //const getAssignedURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/user/read/';
  const getAssignedURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/user/read/';
  var UserList = List<Users>();
  final response = await http.get(getAssignedURL);
  if(response.statusCode == 200)
  {
    //   Assigned.fromJson(json.decode(response.body));
    var UserListJsons = json.decode(response.body);
    for(var UserListJson in UserListJsons)
    {
      UserList.add(Users.fromJson(UserListJson));
    }
    return UserList ;
  }
  else {
    throw HttpException(
        '${response.reasonPhrase}',uri: Uri.parse(getAssignedURL)
    );
  }
}