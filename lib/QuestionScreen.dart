import 'package:flutter/material.dart';
import 'package:mcquizapp/ResultScreen.dart';
import 'dart:async';
import 'QuestionData.dart';
import 'dart:math' as math;

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<QuestionScreen> {
  final COLLECT_FLAG = 1;
  final INCOLLECT_FLAG = 0;
  var _questionOrAnswer = 0; // 0の時、問題。1の時、解答。
  var _questionIndex = 1; // 問題番号
  var _porn = 0; // 解答の判定。0の時、正解。1の時、不正解。
  var _correctCount = 0; // 正解数
  var _correctIndex = 0; //正解のインデックス
  var _randomQuestionList = [];
  var _countdown = 10;
  var _currentCountdownBar = 27.5;
  var _countdownBarPerSecond = 8;

  Timer _timer, _timerBar;

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  // タイマーを止める関数
  void _stopTimer() {
    _timer.cancel();
    _timerBar.cancel();
  }

  // 選択肢を押すときの関数
  void _pressChoiceButton(int index) {
    setState(() {
      _questionOrAnswer = 1;
      _stopTimer();
      if (_correctIndex == _randomQuestionList[index]) {
        _porn = COLLECT_FLAG;
        _correctCount++;
      } else {
        _porn = INCOLLECT_FLAG;
      }
    });
  }

  // 時間を減らす関数
  void _limitedTimer(Timer timer) {
    if (_countdown == 0) {
      setState(() {
        _questionOrAnswer = 1;
        _porn = INCOLLECT_FLAG;
      });
      _timer.cancel();
    } else {
      // print(_countdown);
      _countdown--;
    }
  }

  // バーを減らす関数
  void _limtedTimerBar(Timer t) {
    setState(() {
      if (_currentCountdownBar >= 347.5) {
        _timerBar.cancel();
      }
      // print(_countdownBarPerSecond);
      _currentCountdownBar += _countdownBarPerSecond;
    });
  }

  // 114までのランダムな値を返す関数
  int randomNumber() {
    return new math.Random.secure().nextInt(114);
  }

  // ランダムに４つの解答を用意するリスト型の関数
  List randomQuestionList(int _correctIndex) {
    var i = 0;
    var _questionIndex = 0;
    var _questionList = [];
    _questionList.add(_correctIndex);
    while (i < 3) {
      if (_questionList.contains(_questionIndex = (randomNumber()))) {
      } else {
        _questionList.add(_questionIndex);
        i++;
      }
    }
    _questionList.shuffle();
    return _questionList;
  }

  @override
  void initState() {
    super.initState();
    _correctIndex = randomNumber();
    _randomQuestionList = randomQuestionList(_correctIndex);
    // print("$_correctIndex:$_randomQuestionList");
    _timer = Timer.periodic(Duration(seconds: 1), _limitedTimer);
    _timerBar = Timer.periodic(Duration(milliseconds: 250), _limtedTimerBar);
  }

  // 残り時間のバーを表示するウィジェット
  Container LinearTimerBar() {
    return Container(
      child: Divider(
        color: Colors.blue,
        thickness: 5,
        height: 10,
        indent: 27.5,
        endIndent: _currentCountdownBar,
      ),
    );
  }

  // 正解、不正解のイメージを表示するウィジェット
  Container ImageJudgementWidjet() {
    if (_porn == COLLECT_FLAG) {
      return Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(children: <Widget>[
            Image(
              image: AssetImage('images/maru.png'),
              width: MediaQuery.of(context).size.width - 150,
            ),
            Container(
              child: Text(
                "正解だよ〜ん",
              ),
              margin: EdgeInsets.only(top: 10),
            )
          ]));
    } else if (_porn == INCOLLECT_FLAG) {
      return Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(children: <Widget>[
            Image(
              image: AssetImage('images/batsu.png'),
              width: MediaQuery.of(context).size.width - 150,
            ),
            Container(
              child: Text("正解は「${QuestionData[_correctIndex][0]}」だよ〜ん"),
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            )
          ]));
    } else {
      return Container(
        child: Text("エラーだお"),
      );
    }
  }

  // 問題数をカウントし、次の問題か結果発表に移るかを判断するウィジェット
  Container QuestionIndexCountWidget() {
    if (_questionIndex < 10) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: RaisedButton(
          child: Text("次の問題へ"),
          onPressed: () {
            setState(() {
              _questionIndex++;
              _questionOrAnswer = 0;
              _correctIndex = randomNumber();
              _randomQuestionList = randomQuestionList(_correctIndex);
              _countdown = 10;
              _currentCountdownBar = 27.5;
              _timer = Timer.periodic(Duration(seconds: 1), _limitedTimer);
              _timerBar =
                  Timer.periodic(Duration(milliseconds: 250), _limtedTimerBar);
              // print("$_correctIndex:$_randomQuestionList");
            });
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: RaisedButton(
          child: Text("結果発表"),
          onPressed: () {
            // print("Score is ${_correctCount * 10}.");
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) {
                    return ResultScreen(params: _correctCount);
                  },
                  maintainState: false),
            );
          },
        ),
      );
    }
  }

  // 選択肢を表示するウィジェット
  Container ChoiceButtonWidjet(int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: 80,
          child: RaisedButton(
            child: Text(
              QuestionData[_randomQuestionList[index]][0],
              style: TextStyle(fontSize: 20, height: 1.5),
            ),
            onPressed: () {
              _pressChoiceButton(index);
            },
            padding: EdgeInsets.all(15),
          )),
    );
  }

  // 問題と解答を切り替えるウィジェット
  Container SwitchQandAWidget() {
    if (_questionOrAnswer == 0) {
      return Container(
          child: Column(
        children: <Widget>[
          ChoiceButtonWidjet(0),
          ChoiceButtonWidjet(1),
          ChoiceButtonWidjet(2),
          ChoiceButtonWidjet(3),
        ],
      ));
    } else if (_questionOrAnswer == 1) {
      return Container(
        child: Column(
          children: <Widget>[
            ImageJudgementWidjet(),
            QuestionIndexCountWidget()
          ],
        ),
      );
    } else {
      return Container(
        child: Text("エラーだお"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("問題"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
                child: Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Q$_questionIndex. ${QuestionData[_correctIndex][1]}",
                style: TextStyle(fontSize: 20, height: 1.5),
              ),
            )),
            LinearTimerBar(),
            SwitchQandAWidget()
          ],
        ),
      ),
    );
  }
}
