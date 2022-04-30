import 'package:flutter/material.dart';
import 'package:photo_puzzle_app/puzzle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      ),
    );
  }
}
