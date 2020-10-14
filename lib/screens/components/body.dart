import 'dart:async';
import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/destinations.dart';
import 'package:e_hajiri_app/screens/Login/login.dart';
import 'package:e_hajiri_app/screens/components/destinations_card.dart';
import 'package:e_hajiri_app/screens/details/detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_hajiri_app/models/Assigned.dart' as assigned;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  String Username;
  String UserId;
  Body({Key key, @required this.Username, @required this.UserId})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  Completer<GoogleMapController> _controller = Completer();
  var _future;
  static LatLng latLng;
  List<assigned.Assigned> AssignedList;
  @override
  void initState() {
    super.initState();
    getLocation();
    _future = getAssignedlist(widget.UserId);
   // getAssignedlist();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          //Container(
          //   margin: EdgeInsets.only(
          //    right: kDefaultPadding * 8.9,
          // ),
          //   child: Text("Good Afternoon!",
          //       style: TextStyle(
          //           fontSize: 25,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white), ),

          //  ),
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
            ),
            child: Row(
                children: [
                  SizedBox(width: kDefaultPadding * 0.3),
                  IconButton(
                      icon: new Icon(
                        Icons.account_circle, color: Colors.white, size: 35,),
                    onPressed: ()
                    async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('UserId');
                      prefs.remove('Username');
                      prefs.remove('IsAdmin');

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                    },
                  ),

                  SizedBox(width: kDefaultPadding * 0.3),
                  (Text(//"Ribesh Maharjan",
                      widget.Username,
                    style: TextStyle(fontSize: 20, color: Colors.white),)),
                ]
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                //Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                      )
                  ),
                ),
                // DestinationCard(),
                FutureBuilder<List<assigned.Assigned>> (
                  future: _future,
                  builder: (context,snapshot){
                    if(snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ?    ListView.builder(
                      //here we use our demo products list
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) =>
                          DestinationCard(
                            itemIndex: index,
                            assigned: snapshot.data[index],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(userposition : latLng, index: index,
                                      markPoistion: LatLng(snapshot.data[index].destinationlat,snapshot.data[index].destinationlong)
                                  ,markerTitle : snapshot.data[index].destinationname
                                      , destinationId: snapshot.data[index].destinatonid
                                  ),
                                ),
                              );
                            },
                          ),
                    )
                        : Center(
                        child: CircularProgressIndicator()
                    );
                }
                )

//
//                ListView.builder(
//                  //here we use our demo products list
//                  itemCount: 4,
//                  itemBuilder: (context, index) => ShimmerCard(),
//                )

              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> getLocation() async {
    var geolocation = Geolocator();
    GeolocationStatus geolocationStatus =
    await geolocation.checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position _position) {
          if (_position != null) {
            setState(() {
              latLng = LatLng(_position.latitude, _position.longitude,);
            });
          }
        });
        break;
    }
  }
  Future<List<assigned.Assigned>> getAssignedlist(String UserId) async {

    final List<assigned.Assigned> _AssignedList = await assigned.getPerUserAssigendList(UserId);
    setState(() {
       AssignedList = _AssignedList;
    });
    return _AssignedList;

  }


}


