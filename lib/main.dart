import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/screens/Login/login.dart';
import 'package:e_hajiri_app/screens/administations/adminDashboard.dart';
import 'package:e_hajiri_app/screens/administations/latest/latest_detail.dart';
import 'package:e_hajiri_app/screens/dashboard_screen.dart';
import 'package:e_hajiri_app/screens/delegation/Delegate.dart';
import 'package:e_hajiri_app/screens/loggedDetail/LoggedDetails.dart';
import 'package:e_hajiri_app/screens/loggedDetailMap/LoggedDetailMap.dart';
import 'package:e_hajiri_app/screens/loggedDetailMap/LoggedDetailMapBody.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var UserId = prefs.getString('UserId');
  var Username = prefs.getString('Username');
  var IsAdmin = prefs.getBool('IsAdmin');
//  runApp(MaterialApp(
//      home: user == null ?  LoginScreen() : AdminDashboard()
//  ));
  runApp(MyApp(UserId:UserId ,Username: Username, IsAdmin: IsAdmin));
}

class MyApp extends StatefulWidget {
  String Username;
  String UserId;
  bool IsAdmin;
  MyApp({Key key, @required this.Username, @required this.UserId, @required this.IsAdmin})
      : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Hajiri',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: DashboardScreen(),
      //home: AdminDashboard(),
      //home: LatestDetail(),
      //home: Delegate(),
      // home:  LoginScreen(),
      // home: LoggedList(),
      home: widget.Username == null ? LoginScreen() :
      widget.IsAdmin ? AdminDashboard()
          : DashboardScreen(UserId: widget.UserId, Username: widget.Username,)
       // home: LoggedDetailMap()
    );
  }

}

//class MyApp extends StatelessWidget  {
//
//
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'E-Hajiri',
//      theme: ThemeData(
//        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//        primaryColor: kPrimaryColor,
//        accentColor: kPrimaryColor,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//    //  home: DashboardScreen(),
//      //home: AdminDashboard(),
//      //home: LatestDetail(),
//      //home: Delegate(),
//     // home:  LoginScreen(),
//     // home: LoggedList(),
//    );
//  }
//
//}
