import 'package:flutter/material.dart';
import 'package:photo_puzzle_app/control_button.dart';
import 'package:photo_puzzle_app/score_view.dart';

class Dashboard extends StatelessWidget {
  static const _margin = 20.0;
  static const _space = 10.0;

  const Dashboard({
    Key? key,
    required this.inPlaying,
    required this.playTime,
    required this.tryCount,
    required this.onTogglePlay,
    required this.onReplay,
    required this.onShuffle,
  }) : super(key: key);

  final bool inPlaying;
  final int playTime;
  final int tryCount;
  final VoidCallback onTogglePlay;
  final VoidCallback onReplay;
  final VoidCallback onShuffle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _margin),
      child: Column(
        children: [
          _createScores(context),
          const SizedBox(height: _space),
          _createButtons(),
        ],
      ),
    );
  }

  Widget _createScores(BuildContext context) {
    final scoreViewWidth =
        (MediaQuery.of(context).size.width - _margin * 2 - _space) / 2;

    final mm = (playTime ~/ 60).toString().padLeft(2, "0");
    final ss = (playTime % 60).toString().padLeft(2, "0");
    final playTimeScore = "$mm : $ss";
    final tryCountScore = tryCount.toString();

    return Row(
      children: [
        SizedBox(
          width: scoreViewWidth,
          height: 80,
          child: ScoreView(
            score: playTimeScore,
            label: "Play Time",
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(width: _space),
        SizedBox(
          width: scoreViewWidth,
          height: 80,
          child: ScoreView(
            score: tryCountScore,
            label: "Try Count",
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  Widget _createButtons() {
    final playButtonAsset = inPlaying ? "assets/pause.png" : "assets/play.png";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ControlButton(
          asset: playButtonAsset,
          onPressed: onTogglePlay,
        ),
        ControlButton(
          asset: "assets/replay.png",
          onPressed: onReplay,
        ),
        ControlButton(
          asset: "assets/shuffle.png",
          onPressed: onShuffle,
        ),
      ],
    );
  }
}
