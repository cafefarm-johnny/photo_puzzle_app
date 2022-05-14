import 'package:flutter/material.dart';

class Playground extends StatefulWidget {
  const Playground({
    Key? key,
    required this.pieces,
    required this.playing,
  }) : super(key: key);

  final List<Image> pieces;
  final bool playing;

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {

  final int _thumbIndex = 8;

  @override
  Widget build(BuildContext context) {
    const playgroundSize = 350.0;
    const pieceSize = playgroundSize * 2 / 6;

    // 퍼즐 조각 위젯 생성
    final children = <Widget>[];

    widget.pieces.asMap()
      .forEach((i, piece) {
        if (i == _thumbIndex) {
          children.add(_createThumb(pieceSize));
        } else {
          children.add(_createPiece(i, piece, pieceSize));
        }
      });

    return AbsorbPointer(
      absorbing: !widget.playing,
      child: Container(
        width: playgroundSize,
        height: playgroundSize,
        color: Colors.blueGrey,
        child: Wrap(children: children),
      ),
    );
  }

  Widget _createPiece(int index, Image piece, double pieceSize) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: pieceSize,
        height: pieceSize,
        child: piece,
      ),
    );
  }

  Widget _createThumb(double pieceSize) {
    return GestureDetector(
      onTap: (){},
      child: SizedBox(
        width: pieceSize,
        height: pieceSize,
        child: Container(color: Colors.green),
      ),
    );
  }
}
