import 'package:e_hajiri_app/models/DestinationJson.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';


class LoggedDetailsMapBody extends StatefulWidget {
  LatLng DestinationLocation;
  LatLng LoggedLocation;
  String Destinationtitle;
  LoggedDetailsMapBody({Key key, @required this.DestinationLocation,
    @required this.LoggedLocation,
    @required this.Destinationtitle
  })
      : super(key: key);
  @override
  _LoggedDetailsMapBodyState createState() => _LoggedDetailsMapBodyState();
}

class _LoggedDetailsMapBodyState extends State<LoggedDetailsMapBody> {
  GoogleMapController mapController;
  Set<Marker> _markers = Set();
  Destinations destinations;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // _markers.clear();
    final marker = Marker(
        markerId: MarkerId(widget.Destinationtitle),
        position: LatLng(
            widget.DestinationLocation.latitude, widget.DestinationLocation.longitude)
    );
    // _markers[products[widget.index].title] = marker;
    _markers.add(marker);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildGoogleMap(widget.LoggedLocation),
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
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        // target: LatLng(products[widget.index].latitude, products[widget.index].longitude),
        target: center != null ? center : _center,
        zoom: 8.0,
        //bearing: 30,
      ),

      //polylines: polyline,
    );
  }
}
