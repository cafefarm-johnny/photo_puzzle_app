import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as imglib;

class Puzzle {
  static const _photoAsset = "assets/iu.jpg";
  static const _parts = 3;

  static late final _instance = Puzzle._internal();

  bool ready = false;
  late final List<Image> _pieces;

  List<Image> get pieces {
    final list = List.of(_pieces.sublist(0, _pieces.length - 1));
    list.shuffle();
    list.add(_pieces.last);

    return list;
  }

  factory Puzzle() {
    return _instance;
  }

  Puzzle._internal();

  Future<void> init() async {
    await _preparePieces();

    ready = true;
  }

  Future<void> _preparePieces() async {
    final photoAssetData =
        (await rootBundle.load(_photoAsset)).buffer.asUint8List();

    _pieces = _splitPhoto(photoAssetData);
  }

  List<Image> _splitPhoto(List<int> photoBytes) {
    final photo = imglib.decodeImage(photoBytes);
    final width = ((photo?.width ?? 0) / _parts).round();
    final height = ((photo?.height ?? 0) / _parts).round();
    int x = 0, y = 0;

    final parts = <imglib.Image>[];
    for (int i = 0; i < _parts; i++) {
      for (int j = 0; j < _parts; j++) {
        parts.add(imglib.copyCrop(photo!, x, y, width, height));
        x += width;
      }

      x = 0;
      y += height;
    }

    final pieces = <Image>[];
    for (var img in parts) {
      pieces.add(
        Image.memory(
          Uint8List.fromList(
            imglib.encodeJpg(img),
          ),
          fit: BoxFit.fill,
        ),
      );
    }

    return pieces;
  }

  bool isCompleted(List<Image> pieces) {
    return listEquals(_pieces, pieces);
  }
}
