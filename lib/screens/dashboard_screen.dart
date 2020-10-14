import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/Assigned.dart';
import 'package:e_hajiri_app/screens/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardScreen extends StatefulWidget {
  String Username;
  String UserId;
  DashboardScreen({Key key, @required this.Username, @required this.UserId})
      : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body:
        Body(Username: widget.Username,UserId: widget.UserId)

    );
  }

    AppBar buildAppBar() {
      return AppBar(
        elevation: 0,
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            //icon: SvgPicture.asset("assets/icons/notification.svg"),
            icon: new Icon(Icons.history, color: Colors.white, ),
            onPressed: () {},
          )
        ],

      );
    }

}



