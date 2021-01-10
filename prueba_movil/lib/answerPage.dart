import'myhomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAnswerPage extends StatefulWidget{
  final String UserId;
  final List<Respuestas> UserAnswer;
  MyAnswerPage(this.UserId, this.UserAnswer);
  @override
  State<StatefulWidget> createState() {
    return _MyAnswerPage();
  }

}

class _MyAnswerPage extends State<MyAnswerPage> {
  List<String>AnswerList=[];
  @override
  Widget build(BuildContext context) {
    for(int i=0;i<widget.UserAnswer.length;i++){
      if(widget.UserId == widget.UserAnswer[i].userId){
        AnswerList.add(widget.UserAnswer[i].answer);
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text('Respuestas del usuario'),),resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        Expanded(child: ListView.builder(itemCount: AnswerList.length, itemBuilder: (context,index){
          var respuesta = AnswerList[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:[
                        Colors.pink,
                        Colors.deepPurple
                      ],

                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Text(respuesta, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white) ),
                  ],
                )
            ),
          );
        },))
      ],),
    );
  }
}