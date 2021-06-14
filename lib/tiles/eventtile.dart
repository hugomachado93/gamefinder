import 'package:app2/tabs/userevent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  EventTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  radius: 30.0,
                  backgroundImage: NetworkImage(snapshot.data["imageUrl"]),
                ),
                title: Text(snapshot.data["titulo"]),
                subtitle: Text(snapshot.data["nomeUsuario"]),
              ),
              Text(snapshot.data["local"])
            ],
          ),
        ),
    );
  }

}