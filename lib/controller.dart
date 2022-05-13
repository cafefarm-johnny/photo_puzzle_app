import 'package:flutter/material.dart';

class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  // 버튼 배경, 크기 조정
  static final _elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.grey,
    fixedSize: const Size(90, 90),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildButton(),
    );
  }

  // 버튼간 간격 조정
  Widget _buildButton() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 30,
      runSpacing: 30,
      children: [
        _createPlayButton(),
        _createResetButton(),
        _createShuffleButton(),
      ],
    );
  }

  Widget _createPlayButton() {
    return ElevatedButton(
      onPressed: (){},
      style: _elevatedButtonStyle,
      child: Image.asset(
        "assets/play.png",
      ),
    );
  }

  Widget _createResetButton() {
    return ElevatedButton(
      onPressed: (){},
      style: _elevatedButtonStyle,
      child: Image.asset(
        "assets/replay.png",
      ),
    );
  }

  Widget _createShuffleButton() {
    return ElevatedButton(
      onPressed: (){},
        style: _elevatedButtonStyle,
      child: Image.asset(
        "assets/shuffle.png",
      ),
    );
  }
}
