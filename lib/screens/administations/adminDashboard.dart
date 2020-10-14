import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/adminCategories.dart';
import 'package:e_hajiri_app/screens/Login/login.dart';
import 'package:e_hajiri_app/screens/administations/latest/latest_detail.dart';
import 'package:e_hajiri_app/screens/delegation/Delegate.dart';
import 'package:e_hajiri_app/screens/loggedDetail/LoggedDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String choice = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/menu.svg",
                    color: kPrimaryColor,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: kPrimaryColor,
                    ),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('UserId');
                      prefs.remove('Username');
                      prefs.remove('IsAdmin');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => LoginScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Admin Dashboard",
                style: kHeadingextStyleBlue,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: 16),
                height: kDefaultPadding * 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/search.svg"),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Search for anything",
                      style: TextStyle(fontSize: 18, color: Color(0xFFA0A5BD)),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Catergory",
                    style: kTitleTextStyleBlue,
                  ),
                  Text(
                    "See All",
                    style: kSubtitleTextStyle.copyWith(color: kSecondaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 2,
                    itemCount: categories.length,
                    crossAxisSpacing: kDefaultPadding,
                    mainAxisSpacing: kDefaultPadding,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LatestDetail()),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Delegate()),
                              );
                              break;
                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoggedList()),
                              );
                              break;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          height: index.isEven ? 200 : 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: kBlueColor,
                            image: DecorationImage(
                                image: AssetImage(categories[index].image),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                categories[index].name,
                                style: kTitleTextStyle,
                              ),
                              Text(
                                '${categories[index].numOfCourses} Contents',
                                style: TextStyle(
                                    color: kTextColor.withOpacity(.5)),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
              )
            ],
          )),
    );
  }
}
