import 'package:flutter/material.dart';
import './QuestionScreen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState craeteState() => _HomeScreenState();
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mr.Children検定"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(children: <Widget>[
        Container(
          child: Text(
            "Mr.Children検定",
            style: TextStyle(fontSize: 40),
          ),
          margin: EdgeInsets.only(bottom: 100, top: 125),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: RaisedButton(
            child: Text(
              "スタート",
              style: TextStyle(fontSize: 20),
            ),
            padding: EdgeInsets.all(15),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) {
                      return QuestionScreen();
                    },
                    maintainState: false),
              );
            },
          ),
        )
      ])),
    );
  }
}
