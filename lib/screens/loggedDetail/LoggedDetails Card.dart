import 'package:e_hajiri_app/models/LoggedJson.dart';
import 'package:e_hajiri_app/screens/loggedDetailMap/LoggedDetailMap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';

class LoggedDetailsCard extends StatelessWidget {
  const LoggedDetailsCard({
    Key key,
    this.itemIndex,
    //  this.product,
    this.logged,
    this.press,
  }) : super(key: key);
  final int itemIndex;
  final Function press;
  final Logged logged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      //  color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //Those are our background
            Container(
              height: 160,//136
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                //  color: kBlueColor,
                color: itemIndex.isEven ? kMahgony : kBlueColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22)),
              ),
            ),
            Positioned(
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 1.5, // 30 padding
                    vertical: kDefaultPadding / 4 // 5 top and bottom
                ),
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(22),
                        topLeft: Radius.circular(22))),
                child: GestureDetector(
                  onTap: ()
                  {
                    final snackBar = SnackBar(content: Text(logged.destinationname.toString()));
                    Scaffold.of(context).showSnackBar(snackBar);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoggedDetailMap(
                             DestinationLocation: LatLng(logged.destinatonlat,logged.destinatonlong),
                             LoggedLocation: LatLng(logged.loggedlat, logged.loggedlong),
                             Destinationtitle: logged.destinationname,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    // "\$58",
                    //assigned.date,
                    'Details',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),

      ),
            Positioned(
              bottom: 0,
              //top:0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image takes 200 width, thats why we set out total width -200
                width: size.width - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        //assigned.destinationname,
                       // 'Pharphing HydroPower',
                        logged.destinationname,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,),
                      child: Text(
                        //assigned.destinationname,
                        //'Ribesh Maharjan',
                        logged.username,
                       // style: Theme.of(context).textTheme.button,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:FontWeight.bold
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical:kDefaultPadding/3
                            ),
                            child: Icon(
                                Icons.calendar_today,
                              color: kPrimaryColor,
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding/8,
                                vertical:kDefaultPadding/3
                            ),
                            child:  Text(
                              //'2020-08-29',
                              logged.loggeddate.toString(),
                              style: Theme.of(context).textTheme.button,
                            )
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical:kDefaultPadding/3),
                            child: Icon(
                                Icons.directions_walk,
                              color: kPrimaryColor,
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding/8,
                                vertical:kDefaultPadding/3
                            ),
                            child:  Text(
                              //'0.72 km',
                              logged.loggeddist.truncate().toString() + ' Km',
                              style: Theme.of(context).textTheme.button,
                            )
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //it uses the available space
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
