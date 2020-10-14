import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/LoggedDocCount.dart';
import 'package:e_hajiri_app/models/destinations.dart';
import 'package:e_hajiri_app/screens/components/destinations_card.dart';
import 'package:e_hajiri_app/screens/details/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MapBody extends StatefulWidget {
  LatLng CurrentUserlocation;
  LatLng Markerlocation;
  String markerTitle;
  String destinationId;

  var index;
  MapBody({Key key, @required this.CurrentUserlocation,
    @required this.index, @required this.Markerlocation
  ,@required this.markerTitle
    ,@required this.destinationId
  })
      : super(key: key);
  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  GoogleMapController mapController;
  List<LoggedCount> loggedCountList;
  LatLng loggedlatLng;
  double userLoggedDistance;
  String Username;
  String UserId;

  //final Map<String, Marker> _markers = {};
  Set<Marker> _markers = Set();
  // final Set<Polyline> polyline = {};
//  GoogleMapPolyline googleMapPolyline =
//      new GoogleMapPolyline(apiKey: "AIzaSyBWFcfXwqyXmfnUgJlDU4_dwD7hqVWYYnc");
  Product product;
  // StreamSubscription _locationSubscription;
  //Location _locationTracker = Location();
  //List<LatLng> polylineCordinates;
  Location location = new Location();

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // _markers.clear();
    final marker = Marker(
        markerId: MarkerId(products[widget.index].title),
        position: LatLng(
            widget.Markerlocation.latitude, widget.Markerlocation.longitude)
    );
    // _markers[products[widget.index].title] = marker;
    _markers.add(marker);
//    polyline.add(Polyline(
//        polylineId: PolylineId(products[widget.index].title),
//        visible: true,
//        points: polylineCordinates,
//        color: Colors.lightBlueAccent,
//        startCap: Cap.roundCap,
//        endCap: Cap.buttCap
//    ));
//    _locationSubscription = _locationTracker.onLocationChanged
//        .listen((LocationData currentLocation) {
//      if (mapController != null) {
//        mapController.animateCamera(CameraUpdate.newCameraPosition(
//            new CameraPosition(
//                bearing: 192.8334901395799,
//                target:
//                    LatLng(currentLocation.latitude, currentLocation.longitude),
//                tilt: 0,
//                zoom: 14)));
//      }
//    });
  }

//  void getGooglePolyLines() async {
//    polylineCordinates = await googleMapPolyline.getCoordinatesWithLocation(
//        origin: LatLng(widget.CurrentUserlocation.latitude,
//            widget.CurrentUserlocation.longitude),
//        destination: LatLng(
//            products[widget.index].latitude, products[widget.index].longitude),
//        mode: RouteMode.driving);
//  }

//  @override
//  void dispose() {
//    if (_locationSubscription != null) {
//      _locationSubscription.cancel();
//    }
//    super.dispose();
//  }

  @override
  void initState() {
    super.initState();
    _onMapCreated(mapController);
   // getLoggedDocCount();
    // getGooglePolyLines();
    getLoggedDocCount();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildGoogleMap(widget.CurrentUserlocation),
//          Container(
//            margin: EdgeInsets.only(top: kDefaultPadding * 4),
//            child: Row(
//              children: [
//                (IconButton(
//                  padding: EdgeInsets.symmetric(
//                      vertical: kDefaultPadding, horizontal: kDefaultPadding),
//                  // icon: new Icon (Icons.arrow_back, color: Colors.black,),
//                  icon: SvgPicture.asset("assets/icons/back.svg"),
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                )),
//                Text(
//                  'Back'.toUpperCase(),
//                  style: Theme.of(context).textTheme.bodyText2,
//                ),
//              ],
//            ),
//          ),
//          Positioned(
////              bottom: kDefaultPadding * 2.4,
////              left: kDefaultPadding,
////              child: (FloatingActionButton.extended(
////                  onPressed: () {},
////                  label: Text(
////                    ' हाजिर गर  ',
////                    style: TextStyle(fontSize: 20),
////                  ),
////                  // child: Icon(Icons.navigation),
////                  icon: Icon(Icons.thumb_up),
////                  backgroundColor: Colors.lightBlue)))
          Positioned(
            bottom: kDefaultPadding * 6,
            right: kDefaultPadding * 0.5,
            child: (FloatingActionButton(
              onPressed: () {
                navigateToMaps();
              },
              child: Icon(Icons.navigation),
              backgroundColor: Colors.lightBlueAccent,
            )),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
                initialChildSize: 0.04,
                minChildSize: 0.04,
                maxChildSize: 0.2,
                builder: (BuildContext context, myscrollController) {
                  return Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: SingleChildScrollView(
                          controller: myscrollController,
                        child: Column(
                         children: [
                           FlatButton.icon(
                             onPressed: (){},
                             icon: Icon(Icons.keyboard_arrow_up, color: Colors.white,),
                             label: Text(""),
                             disabledColor: Colors.grey,
                           ),
                           SizedBox(
                             height: 2,
                           )
                            ,Container(
                            margin: EdgeInsets.symmetric(
                               vertical: kDefaultPadding/8,
                              horizontal: kDefaultPadding
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding/2
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFCBF1E),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: <Widget>[
//                              SvgPicture.asset(
//                                  "assets/icons/chat.svg",
//                                  height: 24,
//                              ),
                                SizedBox(width: kDefaultPadding * 5,),
//                                Text(
//                                  'Chat with Us',
//                                  style: TextStyle(color: Colors.black),
//                                ),
                            //    Spacer(),
                                FlatButton.icon(
                                    onPressed: (){
                                      logCurrentLocation();
                                    },
                                    icon: Icon(Icons.thumb_up),
                                    label: Text(" हाजिर गर "),
                                  disabledColor: Colors.grey,
                                )
                              ],
                            ),
                          )]
                        )
                          ));
                }),
          )
        ],
      ),
    );
  }

  GoogleMap buildGoogleMap(LatLng center) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        // target: LatLng(products[widget.index].latitude, products[widget.index].longitude),
        target: center != null ? center : _center,
        zoom: 12.0,
        //bearing: 30,
      ),

      //polylines: polyline,
    );
  }

  void navigateToMaps() async {
    if (await map_launcher.MapLauncher.isMapAvailable(
        map_launcher.MapType.google)) {
      await map_launcher.MapLauncher.showMarker(
        mapType: map_launcher.MapType.google,
        coords: map_launcher.Coords(
            widget.Markerlocation.latitude, widget.Markerlocation.longitude),
        title: widget.markerTitle,
        //description: description,
      );
    } else {
      final snackBar = SnackBar(content: Text('Please install Google Maps'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
  void logCurrentLocation()
  {

    //getLoggedDocCount();
    getCuurentLocationForLogging();

   // var loggedDistance = getDistanceFromGPSPointsInRoute(widget.Markerlocation,loggedlatLng);

//    final snackBar = SnackBar(content: Text(userLoggedDistance.toString() +tologgedlatLng.toString() ));
//    Scaffold.of(context).showSnackBar(snackBar);

  }


  Future<List<LoggedCount>> getLoggedDocCount() async {
    final List<LoggedCount> _loggedCountList = await getLoggedDocCountList();
    setState(() {
      loggedCountList = _loggedCountList;
    });
//    final snackBar = SnackBar(content: Text(loggedCountList[0].doccount.toString()));
//    Scaffold.of(context).showSnackBar(snackBar);
    return loggedCountList;

  }

  void getCuurentLocationForLogging() async {
   // getLoggedDocCount();
    var geolocation = Geolocator();
    LatLng tologgedlatLng;
//    GeolocationStatus geolocationStatus =
//    await geolocation.checkGeolocationPermissionStatus();
//    switch (geolocationStatus) {
//      case GeolocationStatus.denied:
//        print('denied');
//        break;
//      case GeolocationStatus.disabled:
//      case GeolocationStatus.restricted:
//        print('restricted');
//        break;
//      case GeolocationStatus.unknown:
//        print('unknown');
//        break;
//      case GeolocationStatus.granted:
     await Geolocator()
            .getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best)
            .then((Position _position) {
          if (_position != null) {
            setState(() {
              loggedlatLng = LatLng(_position.latitude, _position.longitude,);
            //  tologgedlatLng = LatLng(_position.latitude, _position.longitude,);
//              final snackBar = SnackBar(content: Text(tologgedlatLng.toString()));
//                Scaffold.of(context).showSnackBar(snackBar);
            });
          }
        });
     getDistanceFromGPSPointsInRoute(widget.Markerlocation,loggedlatLng);
     //return tologgedlatLng;

       // break;
   // }
  }

//  static double getDistanceFromGPSPointsInRoute(LatLng DestinationLocation, LatLng LoggedLocation)
   void  getDistanceFromGPSPointsInRoute(LatLng DestinationLocation, LatLng LoggedLocation)
  {

      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((LoggedLocation.latitude - DestinationLocation.latitude) * p)/2 +
          c(DestinationLocation.latitude * p) * c(LoggedLocation.latitude * p) *
              (1 - c((LoggedLocation.longitude - DestinationLocation.longitude) * p))/2;
      userLoggedDistance = 12742 * asin(sqrt(a));
//      final snackBar = SnackBar(content: Text(loggedlatLng.toString() + ''+ userLoggedDistance.toString() + '' + loggedCountList[0].doccount.toString()));
//      Scaffold.of(context).showSnackBar(snackBar);
    postLoggedInformation();
    print(loggedCountList[0].doccount.toInt()+1);
    print(UserId);
    print(Username);
    print(widget.destinationId);
    print(widget.markerTitle);
    print(widget.Markerlocation.latitude);
    print(widget.Markerlocation.longitude);
    print(loggedlatLng.latitude);
    print(loggedlatLng.longitude);
    print(userLoggedDistance);
    print(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() );
  }
  void  getUserInfo() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      UserId = prefs.getString('UserId');
      Username = prefs.getString('Username');
      //return stringValue;
  }
  void postLoggedInformation() async {

    //const createlogURL = 'http://localhost:5001/e-hajiree/us-central1/app/api/logged/create';
    const createlogURL = 'https://us-central1-e-hajiree.cloudfunctions.net/app/api/logged/create';
    final response = await http.post(createlogURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id":(loggedCountList[0].doccount.toInt()+1).toString(),
        "userid": UserId,
        "username": Username.toString(),
        "destinatonid": widget.destinationId,
        "destinationname": widget.markerTitle.toString(),
        "destinatonlat": widget.Markerlocation.latitude,
        "destinatonlong": widget.Markerlocation.longitude,
        "loggedlat": loggedlatLng.latitude,
        "loggedlong":loggedlatLng.longitude,
        "loggeddist": userLoggedDistance,
        "loggeddate": DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
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
}
