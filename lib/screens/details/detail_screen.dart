import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/destinations.dart';
import 'package:e_hajiri_app/screens/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final LatLng userposition;
  final LatLng markPoistion;
  final String markerTitle;
  final String destinationId;
  final index;
  DetailsScreen({Key key, @required this.userposition, @required this.index,
    @required this.markPoistion, @required this.markerTitle ,@required this.destinationId})
      : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body:
        MapBody(CurrentUserlocation: widget.userposition,
            index: widget.index,
            Markerlocation: widget.markPoistion,
            markerTitle: widget.markerTitle,
            destinationId: widget.destinationId
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
