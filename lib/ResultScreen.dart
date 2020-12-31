import 'dart:js';
import 'HomeScreen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final params;
  ResultScreen({Key key, @required this.params}) : super(key: key);

  Container ResultDigreeWidget(int params) {
    if (params <= 5) {
      return Container(
        child: Text("不可", style: TextStyle(fontSize: 100, height: 1.5)),
        margin: EdgeInsets.only(top: 50, bottom: 50),
      );
    } else if (params == 6) {
      return Container(
          child: Text("可", style: TextStyle(fontSize: 200, height: 1.5)));
    } else if (params == 7) {
      return Container(
          child: Text("良", style: TextStyle(fontSize: 200, height: 1.5)));
    } else if (params == 8) {
      return Container(
          child: Text("優", style: TextStyle(fontSize: 200, height: 1.5)));
    } else if (params >= 9) {
      return Container(
          child: Text("秀", style: TextStyle(fontSize: 200, height: 1.5)));
    } else {
      return Container(child: Text("😡😡😡エラーだお😡😡😡"));
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
          children: <Widget>[
            Container(padding: EdgeInsets.only(top: 20)),
            ResultDigreeWidget(params),
            Text("${params * 10}点だよ〜ん"),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: RaisedButton(
                child: Text("ホームに戻る"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                      maintainState: false));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
