import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyeonsookim_tic_tac_toe/common.dart';
import 'package:hyeonsookim_tic_tac_toe/pages/gamePage.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  String randomPlayer() {
    final players = ['playerOne','playerTwo'];
    final _randomplyer = (players.toList()..shuffle())[0];
    print(_randomplyer);
    return _randomplyer;
  }
  late String currentPlayer = randomPlayer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: mediaHeight(context, 0.2)),
            child: Column(
              children: [
                Text('Tic-Tac-Toe'),
                Lottie.asset('assets/tic-tac-toe.json',height: mediaHeight(context, 0.3)),
              ],
            ),
          ),
          CupertinoButton(child: Text('게임 하러가기'), onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('먼저하는 플레이어는 랜덤으로 선택됩니다.'),
                    Text('먼저하는 플레이어는 : $currentPlayer입니다.'),
                    CupertinoButton(child: Text('시작하기'), onPressed: (){
                      print(currentPlayer);
                      Get.to(() => GamePage(currentPlayer:currentPlayer));
                    })
                  ],
                ),
              );
            });
          })
        ],
      ),
    );
  }
}
