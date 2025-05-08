import 'package:flutter/material.dart';

class MainIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color splashColor;
  final Color backGroundColor;
  final double borderRadious;

  const MainIconButton({
    super.key,
    required this.backGroundColor,
    required this.splashColor,
    required this.child,
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
          child: child,
        ),
      ),
    );
  }
}
