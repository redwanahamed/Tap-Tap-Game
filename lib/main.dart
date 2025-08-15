import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MathTapGame()));
}

class MathTapGame extends StatefulWidget {
  @override
  State<MathTapGame> createState() => _MathTapGameState();
}

class _MathTapGameState extends State<MathTapGame> {
  int target = 0;     // number you need to reach
  int count = 0;      // your current number
  int timeLeft = 10;  // countdown in seconds
  String result = ''; // win/lose message
  Timer? timer;       // timer object

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    target = Random().nextInt(99) + 1;
    count = 0;
    timeLeft = 10;
    result = '';
    timer?.cancel(); // stop any old timer

    // start new countdown
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (timeLeft > 0 && result.isEmpty) {
        timeLeft--;
      } else {
        if (result.isEmpty) result = 'Time Up! You Lose!';
        timer?.cancel();
      }
      setState(() {});
    });

    setState(() {});
  }

  void tapButton() {
    count++;
    if (count == target) {
      result = ' You Win!';
      timer?.cancel();
    } else if (count > target) {
      result = ' You Lose!';
      timer?.cancel();
    }
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel(); // clean up timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tap Tap')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Target: $target', style: TextStyle(fontSize: 28)),
            Text('Count: $count', style: TextStyle(fontSize: 24)),
            Text('Time Left: $timeLeft s', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (result.isEmpty && timeLeft > 0) ? tapButton : null,
              child: Text('Tap', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 26)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startNewGame,
              child: Text('Restart', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
