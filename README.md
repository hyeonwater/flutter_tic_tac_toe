# 둘째날.
1. 첫째날에 해결못했던 플레이 1 = O, 플레이 2 = X 를 해결함.
   -> currentPlayer == 'playerOne' ? 'O' : 'X' 이 코드로 플레이어1은 O의 고정 시킬수 있음. 
2. 플레이어 승리 확인 방법은
      그리드뷰 Index를 왼쪽 상단부터 0이고, 오른쪽 하단을 8이라 치면
      0 1 2
      3 4 5
      6 7 8
      이런 모양의 그리드뷰가 생성 
   ex) 0번 데이터가 비어있지 않고 0번 데이터가 1번이랑 똑같고 2번이랑 똑같은 경우 승리 
3. 승리,비김 했을때의 다이얼로그 제작 
4. 다시 시작하기 버튼 구현