import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
  List<Respuestas>AnswerList=[];
  @override
  Widget build(BuildContext context) {
    for(int i=0;i<widget.UserAnswer.length;i++){
      if(widget.UserId == widget.UserAnswer[i].userId){
        AnswerList.add(widget.UserAnswer[i]);
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text('Respuestas del usuario'),),resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        Expanded(child: ListView.builder(itemCount: AnswerList.length, itemBuilder: (context,index){
          var respuesta = AnswerList[index];
          var fecha =DateTime.fromMicrosecondsSinceEpoch(
                    (respuesta.timestamp*1000)).toLocal().toString();
          
            //String  fecha = DateFormat('yy-MM-dd kk:mm').format(fecha_Datetime).toString();
            return Card(
              elevation: 3,
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
                  padding: EdgeInsets.all(13),
                  child: Wrap(verticalDirection: VerticalDirection.down,alignment: WrapAlignment.
                  center ,children: <Widget>[
                Text('guideId: '+ respuesta.guideId, style: TextStyle(fontSize: 10, color: Colors.white),textAlign: TextAlign.start,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 100),),
                Text(fecha, style: TextStyle(fontSize: 10, color: Colors.white),textAlign: TextAlign.right,),
               Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Text(respuesta.answer, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white), textAlign: TextAlign.center,),]),
                Padding(padding: EdgeInsets.only(top: 15)),
                ],
              )
            ),
          );
        },))
      ],),
    );
  }
}
