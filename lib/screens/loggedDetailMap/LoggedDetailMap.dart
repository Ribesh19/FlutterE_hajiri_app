import 'package:e_hajiri_app/screens/loggedDetailMap/LoggedDetailMapBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';

class LoggedDetailMap extends StatefulWidget {
  LatLng DestinationLocation;
  LatLng LoggedLocation;
  String Destinationtitle;
  LoggedDetailMap({Key key, @required this.DestinationLocation,
    @required this.LoggedLocation,
    @required this.Destinationtitle
  })
      : super(key: key);
  @override
  _LoggedDetailMapState createState() => _LoggedDetailMapState();
}

class _LoggedDetailMapState extends State<LoggedDetailMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(context),
        body:
        LoggedDetailsMapBody(DestinationLocation: widget.DestinationLocation,
            LoggedLocation: widget.LoggedLocation,
            Destinationtitle: widget.Destinationtitle,
        )

    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        //icon: new Icon (Icons.arrow_back, color: Colors.black,),
        icon: SvgPicture.asset(
          "assets/icons/back.svg",
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        // style: Theme.of(context).textTheme.bodyText2,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
