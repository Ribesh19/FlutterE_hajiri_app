import 'package:e_hajiri_app/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);
  final String text;
  final Function press;
  final String color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: (56/812.0) * size.height,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: //kPrimaryColor,
        kSecondaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: (18/375.0) *  size.width,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}