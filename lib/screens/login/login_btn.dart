import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';

class LoginBtn extends StatelessWidget {
  String text;
  Color textColor;
  Color bgColor;
  BorderSide? border;
  Function()? onPressed;

  LoginBtn({
    required this.textColor,
    required this.text,
    required this.bgColor,
    this.border,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: border,
        backgroundColor: bgColor,
        minimumSize: const Size.fromHeight(65),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
