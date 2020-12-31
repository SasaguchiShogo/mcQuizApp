import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mcquizapp/ResultScreen.dart';
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

  int randomNumber() {
    return new math.Random.secure().nextInt(114);
  }

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
    // print(_questionList);
    _questionList.shuffle();
    // print(_questionList);
    return _questionList;
  }

  @override
  void initState() {
    super.initState();
    _correctIndex = randomNumber();
    _randomQuestionList = randomQuestionList(_correctIndex);
    print("$_correctIndex:$_randomQuestionList");
  }

  Container ImageJudgementWidjet() {
    if (_porn == COLLECT_FLAG) {
      return Container(
          child: Column(children: <Widget>[
        Image(image: AssetImage('images/maru.png')),
        Text(
          "正解だよ〜ん",
        )
      ]));
    } else if (_porn == INCOLLECT_FLAG) {
      return Container(
          child: Column(children: <Widget>[
        Image(image: AssetImage('images/batsu.png')),
        Text("正解は「${QuestionData[_correctIndex][0]}」だよ〜ん")
      ]));
    }
  }

  Container QuestionIndexCountWidget() {
    if (_questionIndex < 10) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: RaisedButton(
          child: Text("次の問題へ"),
          onPressed: () {
            setState(() {
              _questionIndex++;
              _questionOrAnswer = 0;
              _correctIndex = randomNumber();
              _randomQuestionList = randomQuestionList(_correctIndex);
              print("$_correctIndex:$_randomQuestionList");
            });
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: RaisedButton(
          child: Text("結果発表"),
          onPressed: () {
            print(_correctCount);
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

  Container SwitchQandAWidget() {
    if (_questionOrAnswer == 0) {
      return Container(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 90,
                child: RaisedButton(
                  child: Text(
                    QuestionData[_randomQuestionList[0]][0],
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      if (_correctIndex == _randomQuestionList[0]) {
                        _porn = COLLECT_FLAG;
                        _correctCount++;
                      } else {
                        _porn = INCOLLECT_FLAG;
                      }
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 90,
                child: RaisedButton(
                  child: Text(
                    QuestionData[_randomQuestionList[1]][0],
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      if (_correctIndex == _randomQuestionList[1]) {
                        _porn = COLLECT_FLAG;
                        _correctCount++;
                      } else {
                        _porn = INCOLLECT_FLAG;
                      }
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 90,
                child: RaisedButton(
                  child: Text(
                    QuestionData[_randomQuestionList[2]][0],
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      if (_correctIndex == _randomQuestionList[2]) {
                        _porn = COLLECT_FLAG;
                        _correctCount++;
                      } else {
                        _porn = INCOLLECT_FLAG;
                      }
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 90,
                child: RaisedButton(
                  child: Text(
                    QuestionData[_randomQuestionList[3]][0],
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      if (_correctIndex == _randomQuestionList[3]) {
                        _porn = COLLECT_FLAG;
                        _correctCount++;
                      } else {
                        _porn = INCOLLECT_FLAG;
                      }
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          )
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mr.Children検定"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
                child: Container(
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              padding: EdgeInsets.all(10),
              child: Text(
                "Q$_questionIndex. ${QuestionData[_correctIndex][1]}",
                style: TextStyle(fontSize: 20, height: 1.5),
              ),
            )),
            SwitchQandAWidget()
          ],
        ),
      ),
    );
  }
}
