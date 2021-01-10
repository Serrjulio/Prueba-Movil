import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'answerPage.dart';

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  List<Respuestas> respuestas = [];
  List<String>Users=[];
  @override
  Widget build(BuildContext context) {

      getData().then((respuestas) => {
        this.setState(() {
        this.respuestas = respuestas;
      })
    });


    for(int i=0;i<respuestas.length;i++){
      if(!Users.contains(respuestas[i].userId)){
        Users.add(respuestas[i].userId);
      }
    }


  return Scaffold(
    appBar: AppBar(title: Text('Filtro de usuarios',style: Theme.of(context).textTheme.headline6,)),
      resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(child: Center(
        child: Wrap(spacing: 15.0, runSpacing: 12.0,
          children: Users.map((String data){
            return InkWell(onTap: () => click(data),
              child: Container(width: 150.0,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(offset: Offset(0.0,1.0),blurRadius: 5.0, color: Colors.black),],
                      color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
                  child: Wrap(
                      children: <Widget>[
                        Container(
                          height: 70.0,
                          width: 115.0,
                          padding: EdgeInsets.only(left: 10.0, top: 10.0, right:15.0, bottom:5.0),
                          child: Text(data, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 16.0)),
                          decoration: BoxDecoration(
                              //color: Colors.deepPurpleAccent,
                            gradient: LinearGradient(colors: [Colors.pink, Colors.deepPurple]),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                topLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(160.0),
                              )
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 0.0,top: 20.0,right: 0.0, bottom: 0.0),
                          child: Icon(Icons.person,size: 30.0, ),),
                      ]
                  )
              ),
              );
          }).toList()
          ,)
    )
    )
  );
  }

void click(data){
  Navigator.push(
    context,MaterialPageRoute(builder: (context)=> MyAnswerPage(data,this.respuestas))
  );
}
}
/*RaisedButton(child: Text(data),
onPressed: (){
click(data);
}
);*/

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