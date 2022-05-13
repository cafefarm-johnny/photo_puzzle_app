import 'package:flutter/material.dart';

class Playground extends StatefulWidget {
  const Playground({Key? key}) : super(key: key);

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      color: Colors.blueGrey,
    );
  }
}
