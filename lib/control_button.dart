import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    Key? key,
    required this.asset,
    required this.onPressed,
  }) : super(key: key);

  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          primary: Colors.teal,
          backgroundColor: Colors.white.withOpacity(0.5),
        ),
        child: Image.asset(asset),
      ),
    );
  }
}
