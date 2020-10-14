import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:e_hajiri_app/components/CustomSuffixIcon.dart';
import 'package:e_hajiri_app/components/DefaultButton.dart';
import 'package:e_hajiri_app/components/form_error.dart';
import 'package:e_hajiri_app/components/size_config.dart';
import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/Assigned.dart';
import 'package:e_hajiri_app/models/AssignedDocCount.dart';
import 'package:e_hajiri_app/models/DestinationJson.dart';
import 'package:e_hajiri_app/models/UsersJson.dart';
import 'package:e_hajiri_app/models/destinations.dart';
import 'package:e_hajiri_app/models/latestupdateinfo.dart';
import 'package:e_hajiri_app/screens/delegation/Delegate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DelegateBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: (20 / 375.0) * size.width),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: (30 / 812.0) * size.height * 0.5,
              ),
              Text(
                'साइट भ्रमण फार्म',
                style: kHeadingextStyleBlue,
              ),
              Text(
                'साइट भ्रमणका लागि उपयुक्त \n व्यक्ति छनौट गर्नुहोस्',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: (30 / 812.0) * size.height * 0.05,
              ),
              DelegateBodyForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class DelegateBodyForm extends StatefulWidget {
  @override
  _DelegateBodyFormState createState() => _DelegateBodyFormState();
}

class _DelegateBodyFormState extends State<DelegateBodyForm> {
  DateTime currentDate = DateTime.now();
  DateTime pickedDate;
 // DateTime yesterdayDate = new DateTime(currentDate.year, currentDate.month,currentDate.day-1);
  @override
  void initState() {
    super.initState();
    getUserlist();
    getDestinationList();
    getAssignedDocCount();
  }

  final _formKey = GlobalKey<FormState>();

  final List<String> errors = [];
  String Name;
  String Date;
  //String phoneNumber;
  String selectedDestination;
  Assigned assigned_post;

  ///
  String id;
  String userid;
  String username;
  String destinatonid;
  String destinationname;
  double destinationlat;
  double destinationlong;
  String date;
  String imageurl;



  var _categories_name = List<DropdownMenuItem>();
  var _categories_destination = List<DropdownMenuItem>();
  int assignedDocCount;
  List<Users> userList;
  List<Destinations> desnationList;
  List<AssignedCount> assignedCountList;

  Future<List<Users>> getUserlist() async {

    final List<Users> _UserList = await getAllusersList();
    setState(() {
      userList = _UserList;
      for (final user in userList){
        _categories_name.add(
            DropdownMenuItem(child: Text(user.name), value: user.name,)
        );
      }
    });
    return userList;

  }


  Future<List<Destinations>> getDestinationList() async {

    final List<Destinations> _DestinationList = await getAllDestinations();
    setState(() {
      desnationList = _DestinationList;
      for (final destination in desnationList){
        _categories_destination.add(
            DropdownMenuItem(child: Text(destination.title), value: destination.title));
      }
    });
    return desnationList;

  }

  Future<List<AssignedCount>> getAssignedDocCount() async {

    final List<AssignedCount> _AssignedCountList = await getAssignedDocCountList();
    setState(() {
      assignedCountList = _AssignedCountList;
    });
    return assignedCountList;

  }

 void postAssigment() async{
  //  const creteAssignmentURL = 'http://10.0.2.2:5001/e-hajiri/us-central1/app/api/assign/create';
  //  const creteAssignmentURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/assign/create';
   const creteAssignmentURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/assign/create';

//   final response = await http.post(creteAssignmentURL, body: {
//      "id": assignedDocCount.toString(),
//      "userid": userid,
//      "username":username.toString(),
//      "destinatonid": destinatonid.toString(),
//      "destinationname": destinationname,
//      "destinatonlat": destinationlat ,
//      "destinatonlong": destinationlong,
//      "date": date,
//     "imageurl": imageurl,
//
//    });

    final response = await http.post(creteAssignmentURL,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      body: jsonEncode(<String, dynamic>{
//        "id": 2,
//        "userid": "1",
//        "username": "Ribesh Maharjan",
//        "destinatonid": "2",
//        "destinationname": "Kulekhani Hydropower Reservoir",
//        "destinatonlat":  27.602655,
//        "destinatonlong": 27.602655,
//        "date": "2020/08/31",
//        "imageurl": "https://i.imgur.com/EKXFvHC.jpg",
        "id": assignedDocCount.toString(),
        "userid": userid,
        "username":username.toString(),
        "destinatonid": destinatonid.toString(),
        "destinationname": destinationname,
        "destinatonlat": destinationlat ,
        "destinatonlong": destinationlong,
        "date": date,
        "imageurl": imageurl,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessfulPostDialog();
          });

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }

   //return reply;
  }

 Dialog SuccessfulPostDialog() {
   return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      padding: EdgeInsets.all(kDefaultPadding),
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Successfully Submitted'),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child:  Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Colors.greenAccent)
                          ),
                          child: IconButton(
                              icon:  Icon( Icons.check, color: Colors.white,),
                              onPressed: (){}
                          )
                      )

                    )
                  ],
                ),
              ),
            ),
          );
 }



  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
/*  @override
  void dispose() {
    destinationDate.dispose();
    super.dispose();
  }*/

  void getDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(currentDate.year, currentDate.month,currentDate.day-1),
        firstDate: DateTime(currentDate.year, currentDate.month,currentDate.day-2),
        lastDate: DateTime(2025),
      helpText: 'कृपया मिति छनौट गर्नुहोस्'
    );
    if (picked != null )
      {
        pickedDate = picked;
        if(pickedDate != null) {
          setState(() {
            destinationDate.text =  DateFormat('yyyy-MM-dd').format(pickedDate).toString();
            Date = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
            final snackBar =
                  SnackBar(
                      content: Text(destinationDate.text ));
                  Scaffold.of(context).showSnackBar(snackBar);
          });
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(
            height: (30 / 812.0) * size.height,
          ),
          buildDestinationTextFormField(),
          SizedBox(
            height: (30 / 812.0) * size.height,
          ),
          buildDateTextFormField(context),
          SizedBox(
            height: (30 / 812.0) * size.height,
          ),
          FormError(
            errors: errors,
          ),
          SizedBox(
            height: (30 / 812.0) * size.height,
          ),
          DefaultButton(
            text: "Submit",
            press: () {
              if (_formKey.currentState.validate()) {
                // Do something
                if(selectedDestination.toString() != null  && Name.toString() !=null && Date.toString() !=null) {
                   assignedDocCount = assignedCountList[0].doccount.toInt()+1;
                  for( final user in userList){
                    if(user.name == Name){
                      //assigned_post.userid = 1;
                      //assigned_post.username = user.name;
                       userid = user.id;
                       username = user.name;
                    }
                  }
                  for(final destination in desnationList)
                    {if(destination.title == selectedDestination){
//                      assigned_post.destinatonid = destination.id;
//                      assigned_post.destinationname = destination.title;
//                      assigned_post.destinationlat = destination.latitude;
//                      assigned_post.destinationlong = destination.longitude;
//                      assigned_post.imageurl = destination.imageurl;
//                      assigned_post.date = Date.toString();

                       destinatonid = destination.id;
                       destinationname = destination.title;
                       destinationlat = destination.latitude;
                       destinationlong = destination.longitude;
                       date = Date.toString();
                       imageurl= destination.imageurl;
                    }
                    }
                   postAssigment();
 //                 final snackBar =
//                  SnackBar(
//                      content: Text(assignedDocCount.toString()+ selectedDestination.toString() +Name.toString() +
//                          Date.toString() ));
//                  Scaffold.of(context).showSnackBar(snackBar);
                  destinationDate.text =  DateFormat('yyyy-MM-dd').format(currentDate).toString();
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Delegate(),
                    ),
                  );
                }
              }
            },
          ),
          SizedBox(
            height: (30 / 812.0) * size.height,
          ),
          Text(
            'तपाईंले सबमिट गर्नाले, यस फारममा तोकिएको व्यक्तिलाई  \n सूचित गरिने छ। ',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  TextFormField buildDateTextFormField( BuildContext context) {
  //  destinationDate.text =  DateFormat('yyyy-MM-dd').format(currentDate).toString();
   // Date = DateFormat('yyyy-MM-dd').format(currentDate).toString();
    return TextFormField(
      //initialValue: currentDate.toString() ,
      controller: destinationDate,
      onTap: ()
      {
        FocusScope.of(context).requestFocus(new FocusNode());
        getDate(context) ;
      },
      onSaved: (destinationDate) =>
      {
        Date = destinationDate
      },
      onChanged: (destinationDate) {
        if (destinationDate.isNotEmpty) {
         // destinationDate = text;
          removeError(error: kDateNullError);

        }
        print("Date Change");
        return null;
      },
      validator: (destinationDate) {
        if (destinationDate.isEmpty) {
          addError(error: kDateNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Date",
        hintText: "मिति",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: SvgPicture.asset("assets/icons/Mail.svg")
        suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/calendar_today-black-18dp.svg"),
      ),
    );

  }

  DropdownButtonFormField buildDestinationTextFormField() {

    return DropdownButtonFormField(
      value: selectedDestination,
      isExpanded: true,
//    items: [
//      DropdownMenuItem<String>(child: Text("Sunkoshi HydroPower Station"), value: "Sunkoshi HydroPower Station"),
//      DropdownMenuItem<String>(child: Text("Gandaki HydroPower Station"), value: "Gandaki HydroPower Station")
//    ],
      items: _categories_destination,
      onSaved: (value) => selectedDestination = value,
      onChanged: (value) {
        setState(() {
          selectedDestination = value;
        });
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value == null) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Destination",
        hintText: "ठेगाना",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: SvgPicture.asset("assets/icons/Mail.svg")
        suffixIcon:
            CustomSuffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  DropdownButtonFormField buildFullNameFormField() {

    return DropdownButtonFormField(
      isExpanded: true,
      items: _categories_name,
      value: Name,
      onSaved: (value) => Name = value,
      onChanged: (value) {
        setState(() {
          Name = value;
        });
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value == null) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Full Name",
        hintText: "पुरा नाम",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: SvgPicture.asset("assets/icons/Mail.svg")
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  final destinationDate = TextEditingController();


}
