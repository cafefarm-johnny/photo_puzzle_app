import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_puzzle_app/controller.dart';
import 'package:photo_puzzle_app/playground.dart';
import 'package:photo_puzzle_app/puzzle.dart';
import 'package:photo_puzzle_app/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Image> _pieces;
  late Timer _timer;

  bool _playing = false;
  int _playTime = 0;

  @override
  void initState() {
    super.initState();

    _loadPuzzle();
  }

  Future<void> _loadPuzzle() async {
    await Puzzle().init();

    setState(() {
      _pieces = Puzzle().pieces;
    });
  }

  void _togglePlay() {
    _playing ? _stop() : _start();
  }

  void _stop() {
    _timer.cancel();
    setState(() {
      _playing = false;
    });
  }

  void _start() {
    setState(() {
      _playing = true;
    });

    _timer = resetTimer();
  }

  Timer resetTimer() {
    return Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _playTime++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo puzzle"),
        centerTitle: true,
        backgroundColor: const Color(0xff1d1b19),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xff2a2926),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 30),
            TimerScore(playing: _playing, time: _playTime),
            const SizedBox(height: 20),
            Controller(playing: _playing, togglePlay: _togglePlay),
            const SizedBox(height: 50),
            const Playground(),
          ],
        )
      ),
    );
  }
}
