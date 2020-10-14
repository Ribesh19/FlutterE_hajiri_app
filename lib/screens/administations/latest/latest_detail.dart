import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/Assigned.dart';
import 'package:e_hajiri_app/models/latestupdateinfo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';




class LatestDetail extends StatefulWidget {
  @override
  _LatestDetailState createState() => _LatestDetailState();
}

class _LatestDetailState extends State<LatestDetail> {
  List<Assigned> AssignedList;
  var _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getallAssignedlist();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
            left: 0,
            top: 50,
            right: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/arrow-left.svg",
                        color: Colors.white,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/more-vertical.svg",
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding),
                child: Text(
                  // "Latest Updates",
                  "तोकिएका विवरण",
                  style: kHeadingextStyleBlue.copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                    top: kDefaultPadding /2
                ),
                child: Text(
                  "सामग्रीहरु",
                  style: kTitleTextStyle.copyWith(color: kSecondaryColor,),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    //Our background
                    Container(
                      margin: EdgeInsets.only(top: kDefaultPadding /4),
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding/2),
                      child: FutureBuilder(
                          future: _future,
                          builder: (context,snapshot){
                            if(snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ?    ListView.builder(
                              //here we use our demo products list
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) =>
                                  LatestContent(
                                    itemIndex: index,
                                    assigned: snapshot.data[index],
//                                  press: () {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) => DetailsScreen(userposition : latLng, index: index,
//                                            markPoistion: LatLng(snapshot.data[index].destinationlat,snapshot.data[index].destinationlong)
//                                            ,markerTitle : snapshot.data[index].destinationname
//                                        ),
//                                      ),
//                                    );
//                                  },
                                  ),
                            ) : Center(child: CircularProgressIndicator());
                          }
                      ),
                    )
                    ,
//                    Padding(
//                      padding: EdgeInsets.only(top: kDefaultPadding/2),
//                      child: ListView.builder(
//                        //here we use our demo products list
//                        itemCount: updates.length,
//                        itemBuilder: (context, index) =>
//                            LatestContent(
//                              itemIndex: index,
//                              update: updates[index],
////                            press: () {
////                            },
//                            ),
//                      ),
//                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Assigned>> getallAssignedlist() async {

    final List<Assigned> _AssignedList = await getallAssigendList();
    setState(() {
      AssignedList = _AssignedList;
    });
    return _AssignedList;

  }
}

class LatestContent extends StatelessWidget {
  const LatestContent({
    Key key,
    this.itemIndex,
    //this.update,
    this.assigned,
    //this.press,
  }) : super(key: key);

  final int itemIndex;
  final Assigned assigned;
 // final Update update;
  //final Function press;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //  color: Colors.blueAccent,
      //height: 120,
      child: Padding(
          padding: const EdgeInsets.all(
              kDefaultPadding,),
          child: Row(
            children: <Widget>[
              Text(
                assigned.id,
                style: kHeadingextStyle.copyWith(color: kTextColor.withOpacity(.15),
                  fontSize: 32
                ),
              ),
              Spacer(),
              Container(
                width: size.width/2,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: assigned.username + '\n',
                        style: TextStyle(
                          color: kPrimaryColor.withOpacity(.8),
                          fontSize: 18
                        ),
                      ),
                      TextSpan(
                        text: assigned.destinationname + '\n',
                          style: kSubtitleTextStyle.copyWith(fontWeight: FontWeight.w600,
                          height: 1.5)
                      ),
                      TextSpan(
                        text: assigned.date ,
                        style: TextStyle(
                            color: kSecondaryColor.withOpacity(.8) ,
                            fontSize: 18
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Colors.grey)
                ),
            child: IconButton(
                icon:  Icon(Icons.edit, color: Colors.white,),
                onPressed: (){}
            )
              )

            ],
          ),
        ),
    );

  }
}
