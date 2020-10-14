import 'package:e_hajiri_app/components/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
          (20 / 375.0) * size.width,
          (20 / 375.0) * size.width,
          (20 / 375.0) * size.width,
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: (18 / 375.0) * size.width,
      ),
    );
  }
}