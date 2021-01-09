import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  List<Respuestas> respuestas = [];

  @override
  Widget build(BuildContext context) {
    getData().then((respuestas) => {
      this.respuestas = respuestas
    });
  return Scaffold(
    appBar: AppBar(title: Text("User's Menú"),),
  );
  }

}

final databaseReference = FirebaseDatabase.instance.reference();

Future<List<Respuestas>> getData() async{
  DataSnapshot snapshot = await databaseReference.child('answers/').once();
  List<Respuestas> respuestas = [];
  if(snapshot.value != null){
    //print(snapshot.value);
    snapshot.value.forEach((key, value)  {
      Respuestas respuesta = createMap(value);
      respuestas.add(respuesta);
    });
  }
  /*for(int i=0;i<respuestas.length;i++){
    print('userId: ' + respuestas[i].userId);
    print('answer: ' + respuestas[i].answer);
  }*/
  return respuestas;
}

class Respuestas{
  String answer;
  String userId;

  Respuestas(this.answer,this.userId);

  Map<String, String> toJson(){
    return{
      'answer': this.answer,
      'userId': this.userId
    };
  }
}

Respuestas createMap(record){
  Map<String, String> atributtes = {
    'answer': '',
    'userId': ''
  };
  record.forEach((key,value) => {
    if(key == 'answer' || key == 'userId'){
      atributtes[key] = value
    }
  });
  Respuestas respuesta = new Respuestas(atributtes['answer'], atributtes['userId']);
  return respuesta;
}