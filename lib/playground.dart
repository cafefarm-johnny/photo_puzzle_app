import 'package:flutter/material.dart';

class Playground extends StatefulWidget {
  const Playground({
    Key? key,
    required this.pieces,
    required this.playing,
    required this.isComplete,
    required this.onPuzzleChange,
  }) : super(key: key);

  final List<Image> pieces;
  final bool playing;
  final bool isComplete;
  final VoidCallback onPuzzleChange;

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {

  static const _parts = 3;

  int _thumbIndex = 8;
  bool _thumbSelected = false;

  void _select(int index) {
    if (!_canSwap(index)) {
      setState(() {
        _thumbSelected = false;
      });

      return;
    }

    setState(() {
      _swap(_thumbIndex, index);

      widget.onPuzzleChange();
    });
  }

  void _selectThumb() {
    setState(() {
      _thumbSelected = !_thumbSelected;
    });
  }

  bool _canSwap(int index) {
    if (!_thumbSelected) {
      return false;
    }

    return _canSwapTopBottom(index) || _canSwapLeftRight(index);
  }
  
  bool _canSwapTopBottom(int index) {
    return index == _thumbIndex + _parts || index == _thumbIndex - _parts;
  }
  
  bool _canSwapLeftRight(int index) {
    final rowIndex = _thumbIndex % _parts;
    switch (rowIndex) {
      case 0:
        return index == _thumbIndex + 1;
      case 2:
        return index == _thumbIndex - 1;
      default:
        return index == _thumbIndex + 1 || index == _thumbIndex + 1;
    }
  }

  void _swap(int thumbIndex, int targetIndex) {
    final tmp = widget.pieces[thumbIndex];
    widget.pieces[thumbIndex] = widget.pieces[targetIndex];
    widget.pieces[targetIndex] = tmp;

    _thumbIndex = targetIndex;
    _thumbSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    const playgroundSize = 350.0;
    const pieceSize = playgroundSize * 2 / 6;

    // 퍼즐 조각 위젯 생성
    final children = <Widget>[];

    widget.pieces.asMap()
      .forEach((i, piece) {
        if (!widget.isComplete && i == _thumbIndex) {
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
      onTap: () => _select(index),
      child: SizedBox(
        width: pieceSize,
        height: pieceSize,
        child: piece,
      ),
    );
  }

  Widget _createThumb(double pieceSize) {
    return GestureDetector(
      onTap: _selectThumb,
      child: SizedBox(
        width: pieceSize,
        height: pieceSize,
        child: Container(color: Colors.green),
      ),
    );
  }
}
