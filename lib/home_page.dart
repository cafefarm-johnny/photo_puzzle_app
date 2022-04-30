import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_puzzle_app/board.dart';
import 'package:photo_puzzle_app/dashboard.dart';
import 'package:photo_puzzle_app/puzzle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _inPlaying = false;
  late Timer _timer;

  int _playTime = 0;
  int _tryCount = 0;
  bool _isPuzzleCompleted = false;

  late List<Image> _pieces;

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

  void _handleTogglePlay() {
    _inPlaying ? _stopPuzzle() : _playPuzzle();
  }

  void _handleReplay() {
    setState(() {
      _timer.cancel();
      _inPlaying = false;
      _isPuzzleCompleted = false;
      _playTime = 0;
      _tryCount = 0;
    });
  }

  void _handleShuffle() {
    setState(() {
      _pieces = Puzzle().pieces;
    });
  }

  void _playPuzzle() {
    if (_isPuzzleCompleted) {
      _handleReplay();
      _handleShuffle();
    }

    setState(() {
      _inPlaying = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _playTime++;
      });
    });
  }

  void _stopPuzzle() {
    _timer.cancel();
    setState(() {
      _inPlaying = false;
    });
  }

  void _handlePuzzleChange() {
    setState(() {
      _tryCount++;
    });

    _isPuzzleCompleted = Puzzle().isCompleted(_pieces);
    if (_isPuzzleCompleted) {
      _stopPuzzle();
    }
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
        child: Column(
          children: [
            const SizedBox(height: 50),
            _createDashboard(),
            const SizedBox(height: 50),
            _createBoard(),
          ],
        ),
      ),
    );
  }

  Widget _createDashboard() {
    return Dashboard(
      inPlaying: _inPlaying,
      playTime: _playTime,
      tryCount: _tryCount,
      onTogglePlay: _handleTogglePlay,
      onReplay: _handleReplay,
      onShuffle: _handleShuffle,
    );
  }

  Widget _createBoard() {
    if (!Puzzle().ready) {
      return const SizedBox.shrink();
    }

    return Board(
      pieces: _pieces,
      inPlaying: _inPlaying,
      isPuzzleCompleted: _isPuzzleCompleted,
      onPuzzleChange: _handlePuzzleChange,
    );
  }
}
