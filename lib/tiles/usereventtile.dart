import 'package:app2/tabs/userevent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventUserTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  EventUserTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white,),
      ),
      key: Key(snapshot.documentID),
      onDismissed: (direction) {
        Firestore.instance.collection("events").document(snapshot.documentID).delete();
      },
      child: Card(
        margin: EdgeInsets.all(15.0),
        color: Colors.transparent,
        child: Container(
          //height: 110,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserEvent(snapshot)));
                },
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(snapshot.data["imageUrl"]),
                ),
                title: Text(snapshot.data["titulo"]),
                subtitle: Text(snapshot.data["nomeUsuario"]),
              ),
              Text(snapshot.data["local"])
            ],
          ),
        ),
    ));
  }

}