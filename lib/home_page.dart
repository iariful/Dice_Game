import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _diceList = <String>[
        'images/d1.PNG',
        'images/d2.PNG',
        'images/d3.PNG',
        'images/d4.PNG',
        'images/d5.PNG',
        'images/d6.PNG',
  ];
  int _index1 = 0, _index2 = 0, _diceSum = 0, _point =0;
  bool _hasGameStarted = false;
  bool _isGameOver = false;
  final _random = Random.secure();
  String _gameFinishedMsg = '';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dice Game'),
        ),
        body: Center(
          child: _hasGameStarted ? _gamePage() : _startPage(),
        ),
      ),
    );
  }

  Widget _startPage() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _hasGameStarted = true;
        });
      },
      child: const Text('START'),
    );
  }

  Widget _gamePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _diceList[_index1],
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 5,
            ),
            Image.asset(
              _diceList[_index2],
              width: 100,
              height: 100,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _isGameOver ? null : _rollTheDice,
          child: const Text('ROLL'),
        ),
        Text(
          'Dice Sum: $_diceSum',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if(_point > 0) Text(
          'Your Point: $_point',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green
          ),
        ),
        if(_point > 0 && !_isGameOver) const Text(
          'Keep rolling until you match your point',
          style: TextStyle(
              backgroundColor: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        if(_isGameOver) Text(_gameFinishedMsg, style: TextStyle(fontSize: 25),),
        if(_isGameOver) ElevatedButton(
          onPressed: _resetGame,
          child: const Text('PLAY AGAIN'),
        ),
      ],
    );
  }

  void _rollTheDice() {
    setState(() {
      _index1 = _random.nextInt(6);
      _index2 = _random.nextInt(6);
      _diceSum = _index1 + _index2 + 2;
      if(_point > 0) {
        _checkSecondThrow();
      } else {
        _checkFirstThrow();
      }
    });
  }

  void _checkFirstThrow() {
    switch(_diceSum) {
      case 7:
      case 11:
        _gameFinishedMsg = 'You Win!!!';
        _isGameOver = true;
        break;
      case 2:
      case 3:
      case 12:
        _gameFinishedMsg = 'You Lost!!!';
        _isGameOver = true;
        break;
      default:
        _point = _diceSum;
        break;
    }
  }

  _resetGame() {
    setState(() {
      _hasGameStarted = false;
      _isGameOver = false;
      _index1 = 0;
      _index2 = 0;
      _diceSum = 0;
      _point = 0;
    });
  }

  void _checkSecondThrow() {
    if(_diceSum == _point) {
      _gameFinishedMsg = 'You Win!!!';
      _isGameOver = true;
    } else if(_diceSum == 7) {
      _gameFinishedMsg = 'You Lost!!!';
      _isGameOver = true;
    }
  }
}