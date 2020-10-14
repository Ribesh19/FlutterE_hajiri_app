import 'package:e_hajiri_app/components/DefaultButton.dart';
import 'package:e_hajiri_app/components/size_config.dart';
import 'package:e_hajiri_app/models/LoggedJson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'LoggedDetails Card.dart';

class LoggedList extends StatefulWidget {
  @override
  _LoggedListState createState() => _LoggedListState();
}

class _LoggedListState extends State<LoggedList> {
  List<Logged> LoggedList;
  double defaultsize = SizeConfig.defaultSize;
  var _future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getAssignedlist();
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
                  "हाजिरी गरिएका विवरण",
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
                    Container(
                      margin: EdgeInsets.only(
                        top: kDefaultPadding/16
                      ),
                        child: //LoggedDetailsCard()
                        FutureBuilder<List<Logged>> (
                            future: _future,
                            builder: (context,snapshot){
                              if(snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                  ?    ListView.builder(
                                //here we use our demo products list
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) =>
                                    LoggedDetailsCard(
                                      itemIndex: index,
                                      logged: snapshot.data[index],
                                      press: () {
                                      },
                                    ),
                              )
                                  : Center(
                                  child: CircularProgressIndicator()
                              );
                            }
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Logged>> getAssignedlist() async {

    final List<Logged> _LoggedList = await getallLoggedList();
    setState(() {
      LoggedList = _LoggedList;
    });
    return LoggedList;

  }
}
