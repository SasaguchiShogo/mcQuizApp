import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mcquizapp/HomeScreen.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<QuestionScreen> {
  final COLLECT_FLAG = 1;
  final INCOLLECT_FLAG = 0;
  var _questionOrAnswer = 0; // 0の時、問題。1の時、解答。
  var _questionIndex = 1; // 問題番号
  var _porn = 0;
  var _correctCount = 0;

  @override
  void initState() {
    super.initState();
  }

  Container ImageJudgementWidjet() {
    if (_porn == COLLECT_FLAG) {
      return Container(
        child: Image(image: AssetImage('images/maru.jpg')),
      );
    } else if (_porn == INCOLLECT_FLAG) {
      return Container(
        child: Image(image: AssetImage('images/batsu.jpg')),
      );
    }
  }

  Container QuestionIndexCountWidget() {
    if (_questionIndex < 10) {
      return Container(
        child: RaisedButton(
          child: Text("次の問題へ"),
          onPressed: () {
            setState(() {
              _questionIndex++;
              _questionOrAnswer = 0;
            });
          },
        ),
      );
    } else {
      return Container(
        child: RaisedButton(
          child: Text("結果発表"),
          onPressed: () {
            print(_correctCount);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
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
            child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: RaisedButton(
                  child: Text(
                    "Over",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      _porn = COLLECT_FLAG;
                      _correctCount++;
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: RaisedButton(
                  child: Text(
                    "HANABI",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      _porn = INCOLLECT_FLAG;
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: RaisedButton(
                  child: Text(
                    "乾いたKISS",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      _porn = INCOLLECT_FLAG;
                    });
                  },
                  padding: EdgeInsets.all(15),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: RaisedButton(
                  child: Text(
                    "Hevenly kiss",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _questionOrAnswer = 1;
                      _porn = INCOLLECT_FLAG;
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
            Container(
              child: Text("解答表示"),
            ),
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
                "Q$_questionIndex. 何も語らない 君の瞳の奥に愛を探しても",
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
