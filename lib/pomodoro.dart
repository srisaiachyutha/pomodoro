import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  var stopWatch = Stopwatch();
  var time = Duration(seconds: 0);
  String display = '25:00';
  Duration value = Duration(minutes: 0,seconds: 5);
  String stopOrContinue = 'Stop';
  bool flagForButton = true;
  final player = AudioCache();


  bool _isrunning( ){
    return stopWatch.isRunning;
  }
  void _stopWatchTimer(){
    stopWatch.stop();
  }
  void _startWatchTimer(){
    //stopWatch.start();
    setState(() {
      flagForButton = false;
      stopWatch.start();

    });

  }
  void _resetTimer(){
    stopWatch.reset();
    setState(() {
      time = Duration(seconds: 0);
      flagForButton = true;
      stopOrContinue = 'Stop';
      display = '25:00';
    });
  }


  void _playAlertSound() async{
    player.play('alert.wav');
    player.play('alert.wav');
  }


  void _timerStart(){
    Timer(Duration(seconds: 1),_mainControler);

  }

  void _mainControler(){
    setState(() {
      time += Duration(seconds: 1);
      display = (value - time).elapsed.toMinutes.toString()+(value - time).elapsed.toSeconds.toString();
      if(time < value){
        if(_isrunning()){
        _timerStart();}
      }else{
        _stopWatchTimer();
        _playAlertSound();
        _resetTimer();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Text('$display'),
            flagForButton?FlatButton(
              //start button
              child : Text('Start'),
              onPressed: _startWatchTimer,
            ):Row(
              children: [
                FlatButton(
                  //reset button
                  child: Text('Reset'),
                  onPressed: _resetTimer,
                ),
                FlatButton(
                  //stop and continue button
                  child: Text('$stopOrContinue'),
                  onPressed: (){
                    setState(() {
                      if(stopOrContinue == 'Stop'){
                        stopOrContinue = 'Continue';
                        _stopWatchTimer();

                      }else{
                        stopOrContinue = 'Stop';
                        _mainControler();
                      }

                    });
                  },
                )
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
