import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index], size: size)),
    );
  }

  Row formErrorText({String error, Size size}) {

    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: (14/375.0) *  size.width,
          width: (14/375.0) *  size.width,
        ),
        SizedBox(
          width: (14/375.0) *  size.width,
        ),
        Text(error),
      ],
    );
  }
}