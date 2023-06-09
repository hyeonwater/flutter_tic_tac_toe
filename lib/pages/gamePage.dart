import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hyeonsookim_tic_tac_toe/common.dart';

class GamePage extends StatefulWidget {

  const GamePage({required this.currentPlayer,Key? key}) : super(key: key);
  final currentPlayer;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  Random random = Random();
  late List<String> emptyCard;
  bool changeTurn = true;
  bool drawBool = false;
  int drawNum = 0; /// 비기는 경우 카운트
  int notationNum = 0; /// 기보 카운트
  List notation = ["", "", "", "", "", "", "", "", ""]; /// 기보 초기 세팅
  double horizontalPadding = 0.02; /// 슬라이드 할 경우 수평패딩이 변경 가능하게 함
  bool darkMode = false;

  @override
  void initState() {
    print(widget.currentPlayer);
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    emptyCard = ["", "", "", "", "", "", "", "", ""];
    drawNum = 0;
    notation = ["", "", "", "", "", "", "", "", ""];
    notationNum = 0;
    changeTurn = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(Icons.arrow_back_ios,color: Color(0xff464a59),size: mediaHeight(context, 0.03)),
          onPressed: () {
            Get.close(2);
            Get.changeTheme(ThemeData.light()); /// HomePage gif파일 배경이 흰색이므로 라이트모드로 강제 변환
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: mediaHeight(context, 0.02)),
            child: Row(
              children: [
                Container(
                  margin:EdgeInsets.only(right: mediaHeight(context, 0.01)),
                  child: CupertinoSwitch(
                    activeColor: Colors.grey,
                    value: darkMode,
                    onChanged: (value){
                      darkMode = value;
                      setState(() {
                        darkMode != false;
                        Get.changeTheme(Get.isDarkMode? ThemeData.light(): ThemeData.dark());
                      });
                    },
                  ),
                ),
                Text(darkMode ? 'Dark mode' : 'Light mode',style: CustomTextStyle.w300(context,color: darkMode ? Colors.white : Colors.black),),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mediaHeight(context, horizontalPadding),vertical: mediaHeight(context, 0.05)),
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
          ),
          Expanded(
            child: Container(
              width: mediaHeight(context, 0.4),
              child: CupertinoSlider(
                /// 슬라이드를 하여 그리드뷰 패딩값을 조절해 게임판 조절 가능
                  value: horizontalPadding,
                  min: 0.02,
                  max: 0.07,
                  onChanged: (value){
                setState(() {
                  horizontalPadding = value;
                });
              },
                activeColor: Colors.green,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Text('다시 시작하기',style: CustomTextStyle.w300(context,color: darkMode ? Colors.white : Colors.black),),
                  onPressed: () {
                    setState(() {
                      initializeGame();
                    });
                  },
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _card(int index){
    return GestureDetector(
      onTap: (){
        if(emptyCard[index].isEmpty){
          setState(() {
            if(changeTurn){
                emptyCard[index] = widget.currentPlayer == 'playerOne' ? 'O' : 'X';
                drawNum += 1;
                notationNum += 1;
                notation[index] = notationNum;
            }else{
              emptyCard[index] = widget.currentPlayer == 'playerOne' ? 'X' : 'O';
              drawNum += 1;
              notationNum += 1;
              notation[index] = notationNum;
            }
          });
          changeTurn = !changeTurn;
          _checkWin();
        }
      },
      child: Container(
        color: emptyCard[index] == 'O' ? Colors.green :Colors.grey,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: notation[index] == notationNum ? 4 : 6,
                    child: Center(child: Text(emptyCard[index],style: CustomTextStyle.w600(context,scale: 0.05),))),
                Expanded(
                  flex: notation[index] == notationNum ? 1 : 3,
                    child: Text('${notation[index]}')),
                if(notation[index] == notationNum)/// 기보가 카드에 있는 Index랑 기보 카윤트가 똑같을때만 실행
                Expanded(
                  flex: 2,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(notation[index] == notationNum ? '무르기' : '',style: CustomTextStyle.w500(context,color: Colors.white,scale: 0.013),),
                    onPressed: () {
                      /// 무르기 기능
                        setState(() {
                          changeTurn = !changeTurn;
                          if(notationNum > 0){
                            notationNum --;
                            drawNum --;
                          }
                          emptyCard[index] = '';
                          emptyCard[index];
                          notation[index] = '';
                          notation[index];
                        });

                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _checkWin(){
    /// 그리드뷰 Index를 왼쪽 상단부터 0이고, 오른쪽 하단을 8이라 치면
    /// 0 1 2
    /// 3 4 5
    /// 6 7 8
    /// 이런 모양의 그리드뷰가 생성

    /// 0번 데이터가 비어있지 않고 0번 데이터가 1번이랑 똑같고 2번이랑 똑같은 경우
    if(emptyCard[0].isNotEmpty && emptyCard[0] == emptyCard[1] && emptyCard[0] == emptyCard[2] ){
      _winDialog(emptyCard[0]);
    }
    /// 3번 데이터가 비어있지 않고 3번 데이터가 4번이랑 똑같고 5번이랑 똑같은 경우
    else if(emptyCard[3].isNotEmpty && emptyCard[3] == emptyCard[4] && emptyCard[3] == emptyCard[5]){
      _winDialog(emptyCard[3]);
    }
    /// 6번 데이터가 비어있지 않고 6번 데이터가 7번이랑 똑같고 8번이랑 똑같은 경우
    else if(emptyCard[6].isNotEmpty && emptyCard[6] == emptyCard[7] && emptyCard[6] == emptyCard[8]){
      _winDialog(emptyCard[6]);
    }
    /// 1번 데이터가 비어있지 않고 1번 데이터가 4번이랑 똑같고 7번이랑 똑같은 경우
    else if(emptyCard[1].isNotEmpty && emptyCard[1] == emptyCard[4] && emptyCard[1] == emptyCard[7]){
      _winDialog(emptyCard[1]);
    }
    /// 2번 데이터가 비어있지 않고 2번 데이터가 5번이랑 똑같고 8번이랑 똑같은 경우
    else if(emptyCard[2].isNotEmpty && emptyCard[2] == emptyCard[5] && emptyCard[2] == emptyCard[8]){
      _winDialog(emptyCard[2]);
    }
    /// 0번 데이터가 비어있지 않고 0번 데이터가 4번이랑 똑같고 8번이랑 똑같은 경우
    else if(emptyCard[0].isNotEmpty && emptyCard[0] == emptyCard[4] && emptyCard[0] == emptyCard[8]){
      _winDialog(emptyCard[0]);
    }
    /// 2번 데이터가 비어있지 않고 2번 데이터가 4번이랑 똑같고 6번이랑 똑같은 경우
    else if(emptyCard[2].isNotEmpty && emptyCard[2] == emptyCard[4] && emptyCard[2] == emptyCard[6]){
      _winDialog(emptyCard[2]);
    }
    else if(drawNum == 9){
      setState(() {
        drawBool = true;
        if(drawNum == 9 && drawBool == true){  /// drawNum이 9개이고 _checkWin에서 승리조건이 아무것도 없을때 실행
          _drawDialog();
        }
      });
    }
  }

  void _drawDialog(){
    showDialog(barrierDismissible: false,
        context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text('비겼습니다',textAlign:TextAlign.center,style: CustomTextStyle.w300(context,scale:0.02,color: darkMode ? Colors.white : Colors.black)),
        content: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('확인',style: CustomTextStyle.w300(context,color: darkMode ? Colors.white : Colors.black),),
          onPressed: () {
            Get.back();
            setState(() {
              initializeGame();
            });
          },
        ),
      );
    });
  }

  void _winDialog(String winner){
    showDialog(
        barrierDismissible: false,
        context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text('${winner != 'X' ? '플레이어 1' : '플레이어 2' }이(가) 이겼습니다.',textAlign:TextAlign.center,style: CustomTextStyle.w300(context,scale:0.02,color: darkMode ? Colors.white : Colors.black)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CupertinoButton(
                child: Text('앱 종료하기',style: CustomTextStyle.w300(context,color: darkMode ? Colors.white : Colors.black)),
                onPressed: () {
                  if(Platform.isIOS){
                    exit(0);
                  }else{
                    SystemNavigator.pop(); /// SystemNavigator.pop() 이 코드는 안드로이드 한정 코드
                  }
                },
              ),
            ),
            Expanded(
              child: CupertinoButton(
                child: Text('한번 더 하기',style: CustomTextStyle.w300(context,color: darkMode ? Colors.white : Colors.black)),
                onPressed: () {
                  Get.back();
                  setState(() {
                    initializeGame();
                    }
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
}
}
