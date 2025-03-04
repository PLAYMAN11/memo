import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memo/config/session.dart';

import 'config.dart';

class GameTimer {
  static Timer? _counter;
  static int _seconds = 180;

  static void startTimer(BuildContext context, Nivel? nivel) {
    stopTimer();
    _counter = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        timer.cancel();
        showDialog(context: context, builder: (context) => Lost(context, nivel));
      } else {
        _seconds--;
      }
    });
  }

  static void resetTimer() {
    stopTimer();
    _seconds = 180;
  }

  static void stopTimer() {
    if (_counter != null) {
      _counter!.cancel();
      _counter = null;
    }
  }

  static String getTime() {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  static void setDuration(int seconds) {
    _seconds = seconds;
  }

  static int getSeconds() {
    return _seconds;
  }
}

void startTimer(BuildContext context, Nivel? nivel) {
  GameTimer.startTimer(context, nivel);
}

void resetTimer() {
  GameTimer.resetTimer();
}

void stopTimer() {
  GameTimer.stopTimer();
}

String getTime() {
  return GameTimer.getTime();
}