import 'package:app2/tiles/eventtile.dart';
import 'package:app2/tiles/usereventtile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyEvent extends StatefulWidget {

  final String _id;

  MyEvent(this._id);

  @override
  _MyEventState createState() => _MyEventState(_id);

}

class _MyEventState extends State<MyEvent> {

  final String _id;

  _MyEventState(this._id);

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey,
            Colors.blue
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
        )
      ),
      //color: Colors.grey,
      child: StreamBuilder<QuerySnapshot>(
        stream: filtrarEventosDoUsuario(),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView(
              children: snapshot.data.documents.map(
                (f) => EventUserTile(f)
              ).toList()
            );
          }
        }
      ),
    );
  }

  Stream<QuerySnapshot> filtrarEventosDoUsuario() {
    return Firestore.instance.collection("events").where('userId', isEqualTo: _id).snapshots();
  }

}