
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAnswerPage extends StatefulWidget{
  final String UserId;
  MyAnswerPage(this.UserId);
  @override
  State<StatefulWidget> createState() {
    return _MyAnswerPage();
  }

}

class _MyAnswerPage extends State<MyAnswerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.UserId)),
    );
  }
}