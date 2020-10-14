import 'package:e_hajiri_app/screens/administations/adminDashboard.dart';
import 'package:e_hajiri_app/screens/delegation/components/delegatebody.dart';
import 'package:flutter/material.dart';

class Delegate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => AdminDashboard(),
//              ),
//            );
            Navigator.pushAndRemoveUntil( context, MaterialPageRoute(
              builder: (context) => AdminDashboard(),
            ), (route) => false);
          },
        ),
        //title: //Text("Delegate Visits", style: kHeadingextStyle.copyWith(color: Colors.white),)
      ),
      body: DelegateBody(),
    );
  }
}
