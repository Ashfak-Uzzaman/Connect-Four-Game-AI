import 'package:connect_four_game/components/text.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final Color splashColor;
  final Color backGroundColor;
  final double borderRadious;
  final VoidCallback? onTap;

  const MainButton({
    super.key,
    required this.backGroundColor,
    required this.splashColor,
    required this.text,
    required this.fontSize,
    required this.fontColor,
    required this.onTap,
    this.borderRadious = 20.0, // default value 20.0
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadious),
      splashColor: splashColor,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadious),
            color: backGroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: MainText(
              text: text,
              fontSize: 35,
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
