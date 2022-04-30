import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  static const _margin = 20.0;

  const Board({
    Key? key,
    required this.pieces,
    required this.inPlaying,
    required this.isPuzzleCompleted,
    required this.onPuzzleChange,
  }) : super(key: key);

  final List<Image> pieces;
  final bool inPlaying;
  final bool isPuzzleCompleted;
  final VoidCallback onPuzzleChange;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  static const _parts = 3;

  int _thumbIndex = 8;
  bool _thumbSelected = false;

  void _handlePieceSelect(int index) {
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

  void _handleThumbSelect() {
    setState(() {
      _thumbSelected = !_thumbSelected;
    });
  }

  bool _canSwap(int index) {
    if (!_thumbSelected) {
      return false;
    }

    // 상하 이동 가능 여부
    if (index == _thumbIndex + _parts || index == _thumbIndex - _parts) {
      return true;
    }

    // 좌우 이동 가능 여부
    final rowIndex = _thumbIndex % _parts;
    switch (rowIndex) {
      case 0:
        return index == _thumbIndex + 1;
      case 2:
        return index == _thumbIndex - 1;
      default:
        return index == _thumbIndex + 1 || index == _thumbIndex - 1;
    }
  }

  void _swap(int thumbIndex, int targetIndex) {
    var tmp = widget.pieces[thumbIndex];
    widget.pieces[thumbIndex] = widget.pieces[targetIndex];
    widget.pieces[targetIndex] = tmp;

    _thumbIndex = targetIndex;
    _thumbSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width - Board._margin * 2;
    final pieceSize = boardSize / _parts;

    final children = <Widget>[];
    widget.pieces.asMap().forEach((i, p) {
      if (!widget.isPuzzleCompleted && i == _thumbIndex) {
        children.add(_createThumb(pieceSize));
      } else {
        children.add(_createPiece(i, p, pieceSize));
      }
    });

    return AbsorbPointer(
      absorbing: !widget.inPlaying,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: boardSize,
        height: boardSize,
        color: Colors.white,
        child: Wrap(children: children),
      ),
    );
  }

  Widget _createPiece(int index, Image piece, double pieceSize) {
    return GestureDetector(
      onTap: () => _handlePieceSelect(index),
      child: SizedBox(
        width: pieceSize,
        height: pieceSize,
        child: piece,
      ),
    );
  }

  Widget _createThumb(double pieceSize) {
    final color = _thumbSelected ? Colors.greenAccent : Colors.green;

    return GestureDetector(
      onTap: _handleThumbSelect,
      child: SizedBox(
        width: pieceSize,
        height: pieceSize,
        child: Container(color: color),
      ),
    );
  }
}
