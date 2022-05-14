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
  bool _isComplete = false;
  int _playTime = 0;
  int _tryCount = 0;

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

  void _toggleReset() {
    setState(() {
      _timer.cancel();
      _playing = false;
      _isComplete = false;
      _playTime = 0;
      _tryCount = 0;
    });
  }

  void _toggleShuffle() {
    setState(() {
      _pieces = Puzzle().pieces;
    });
  }

  void _stop() {
    _timer.cancel();
    setState(() {
      _playing = false;
    });
  }

  void _start() {
    if (_isComplete) {
      _toggleReset();
      _toggleShuffle();
    }

    setState(() {
      _playing = true;
    });

    _timer = resetTimer();
  }

  void _movePuzzle() {
    setState(() {
      _tryCount++;
    });

    _isComplete = Puzzle().isCompleted(_pieces);
    if (_isComplete) {
      _stop();
    }
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
            TimerScore(playing: _playing, time: _playTime, tryCount: _tryCount),
            const SizedBox(height: 20),
            Controller(
                playing: _playing,
                togglePlay: _togglePlay,
                toggleReset: _toggleReset,
              toggleShuffle: _toggleShuffle,
            ),
            const SizedBox(height: 50),
            _buildPlayground(),
          ],
        )
      ),
    );
  }

  Widget _buildPlayground() {
    if (!Puzzle().ready) {
      return const SizedBox.shrink();
    }

    return Playground(
      pieces: _pieces,
      playing: _playing,
      isComplete: _isComplete,
      onPuzzleChange: _movePuzzle,
    );
  }
}
