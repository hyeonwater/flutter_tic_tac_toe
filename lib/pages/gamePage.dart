import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hyeonsookim_tic_tac_toe/common.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  Random random = Random();
  late List<String> emptyCard;
  late String currentPlayer;

  @override
  void initState() {
    initializeGame();
    randomPlayer();
    super.initState();
  }


  String randomPlayer() {
    final players = ['playerOne','playerTwo'];
    final _randomplyer = (players.toList()..shuffle())[0];
    print(_randomplyer);
    return _randomplyer;
  }

  void initializeGame() {
    emptyCard = ["", "", "", "", "", "", "", "", ""];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: mediaHeight(context, 0.8),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3
                ),
                itemCount: 9,
                itemBuilder: (context,index){
                  return _card(index);
                }),
          ),
        ],
      ),
    );
  }

  Widget _card(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
        });
      },
      child: Container(
        color: Colors.blue,
        child: randomPlayer == 'playerOne' ? Text('O') : Text('X'),
      ),
    );
  }
}
