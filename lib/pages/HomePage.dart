import 'package:animated_text_kit/animated_text_kit.dart';
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
                Container(
                  margin: EdgeInsets.only(bottom: mediaHeight(context, 0.03)),
                  child: DefaultTextStyle(
                    style: CustomTextStyle.w500(context,scale: 0.025),
                    child: AnimatedTextKit(animatedTexts: [
                      WavyAnimatedText('Tic-Tac-Toe')
                    ],
                    repeatForever: true,),
                  ),
                ),
                Lottie.asset('assets/tic-tac-toe.json',height: mediaHeight(context, 0.3)),
              ],
            ),
          ),
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text('게임 하러가기',style: CustomTextStyle.w400(context)),
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('플레이어는 랜덤으로 시작됩니다',style: CustomTextStyle.w300(context),),
                        Container(
                          margin: EdgeInsets.only(top: mediaHeight(context, 0.01),bottom: mediaHeight(context, 0.025)),
                            child: Text('먼저하는 플레이어는 : ${currentPlayer == 'playerOne' ?'플레이어 1':'플레이어2'}입니다.',style: CustomTextStyle.w300(context),)),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                            child: Text('시작하기'), onPressed: (){
                          print(currentPlayer);
                          Get.offAll(() => GamePage(currentPlayer:currentPlayer));
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
