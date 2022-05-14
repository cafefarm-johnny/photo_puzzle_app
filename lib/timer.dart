import 'package:flutter/material.dart';

class TimerScore extends StatelessWidget {
  const TimerScore({
    Key? key,
    required this.playing,
    required this.time,
  }) : super(key: key);

  final bool playing;
  final int time;

  final _width = 180.0;
  final _height = 80.0;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _createTimer(),
        _createCounter(),
      ],
    );
  }


  Widget _createTimer() {
    final minute = (time ~/ 60).toString().padLeft(2, "0");
    final second = (time % 60).toString().padLeft(2, "0");
    final timeFormat = "$minute : $second";

    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      // color: Colors.redAccent,
      width: _width,
      height: _height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeFormat,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Play Time",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ),
          ),
        ],
      ),
    );
  }

  Widget _createCounter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: _width,
      height: _height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "0",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Try Count",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}
