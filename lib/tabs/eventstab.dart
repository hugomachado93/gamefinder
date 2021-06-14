import 'package:app2/tiles/eventtile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {

  @override
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
        stream: Firestore.instance.collection("events").snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView(
              children: snapshot.data.documents.map(
                (f) => EventTile(f)
              ).toList()
            );
          }
        }
      ),
    );
  }

}