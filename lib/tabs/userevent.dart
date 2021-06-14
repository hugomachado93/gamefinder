import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class UserEvent extends StatefulWidget {

  final DocumentSnapshot snapshot;

  UserEvent(this.snapshot);

  @override
  _UserEventState createState() => _UserEventState(snapshot);

}

class _UserEventState extends State<UserEvent> {

  CameraPosition _kGooglePlex;

  GoogleMapController googleMapController;
  List<Marker> marker = [];

  final DocumentSnapshot snapshot;
  SharedPreferences _prefs;
  DocumentSnapshot novoAmigo;

  bool isAdicionado;
  bool isNavegando = true;

  _UserEventState(this.snapshot);

  @override
  void initState(){

    _kGooglePlex = CameraPosition(
      target: LatLng(0, 0),
      zoom: 0
    );

    super.initState();
    setState(() {
     isAdicionado = false; 
     navegaNoMapa();
    });
    verificaAmigoAdicionado();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold( 
        appBar: AppBar(
          title: Text(snapshot.data["titulo"]),
        ),
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueAccent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
            )
          ),
          child: Stack(
          children: <Widget>[
            Container(
              height: 270.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.blueAccent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0)
                )
              ),
            ),
            Column(
            children: <Widget>[
              Text(snapshot.data["nome"],
              style: TextStyle(
                  fontSize: 50.0
                ),
              ),
              Container(
                height: 200.0,
                width: 200.0,
                child: CachedNetworkImage(
                  imageUrl: snapshot.data["imageUrl"],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text("Descrição"),
              Text(snapshot.data["descricao"], style: TextStyle(fontSize: 20.0),),
              Divider(
                color: Colors.black,
                height: 30.0,
              ),
              Text("Localização"),
              !isNavegando ? Container(
                height: 150.0,
                width: 410.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue, width: 2.0)
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: Set.from(marker),
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                )
              ) : Container(),
              Text(snapshot.data["local"]),
              SizedBox(height: 10.0),
              !isAdicionado ? FlatButton.icon(
                label: Text("Adicionar como amigo"),
                color: Colors.green,
                icon: Icon(Icons.add),
                onPressed: addFriend
              ) : FlatButton.icon(
                label: Text("Ja foi adicionado"),
                color: Colors.red,
                icon: Icon(Icons.done),
                onPressed: (){}
              )
            ],
          )]
        ),
      ),
    ));
  }

  void navegaNoMapa() {

    Geolocator().placemarkFromAddress(snapshot.data["local"]).then((result) {
        
    _kGooglePlex = CameraPosition(
      target: LatLng(result[0].position.latitude, result[0].position.longitude),
      zoom: 18.0
    );

    marker.add(Marker(
      markerId: MarkerId("Localização"),
      draggable: false,
      position: LatLng(result[0].position.latitude, result[0].position.longitude)
      ));
    });

  }

  void verificaAmigoAdicionado() async {
    _prefs = await SharedPreferences.getInstance();

    QuerySnapshot queryGetFriend = await Firestore.instance.collection("users").where('id', isEqualTo: snapshot.data["userId"]).getDocuments();
    QuerySnapshot queryFriendList = await Firestore.instance.collection("users").document(_prefs.getString("id")).collection("friends").where('id', isEqualTo: snapshot.data["userId"]).getDocuments();

    if(queryFriendList.documents.length == 0){
      setState(() {
       isAdicionado = false;
       novoAmigo = queryGetFriend.documents[0];
      });
    } else {
      setState(() {
       isAdicionado = true; 
      });
    }
    isNavegando = false;
  }

  void addFriend() async {
   if(!isAdicionado) {
      await Firestore.instance.collection("users").document(_prefs.getString("id")).collection("friends").document(novoAmigo.data["id"]).setData(
        {
          'nickname': novoAmigo.data["nickname"],
          'photoUrl': novoAmigo.data["photoUrl"],
          'id': novoAmigo.data["id"]
        }
      );

      await Firestore.instance.collection("users").document(novoAmigo.data["id"]).collection("friends").document(_prefs.getString("id")).setData(
        {
          'nickname': _prefs.getString("nickname"),
          'photoUrl': _prefs.getString("photoUrl"),
          'id': _prefs.getString("id")
        }
      );
      
      setState(() {
       isAdicionado = true; 
      });

    } else {
      setState(() {
       isAdicionado = true; 
      });
      print("usuario ja esta na lista de amigos");
    }
  }

}