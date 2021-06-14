import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import "package:google_maps_webservice/geocoding.dart";

class FormScreen extends StatefulWidget {

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File imageFile;
  bool isLoading;
  String imageUrl;

  String _title;
  String _nome;
  String _local;
  String _descricao;

  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  void getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey,
      body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Icon(
            Icons.event_note,
            color: Colors.pink,
            size: 150
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
              TextFormField(
                validator: isValid,
                decoration: InputDecoration(
                  hintText: "Titulo"
                ),
                onSaved: (String value ){
                  _title = value;
                }
              ),
            TextFormField(
              validator: isValid,
              decoration: InputDecoration(
                hintText: "Local"
              ),
              onSaved: (String value ){
                _local = value;
              }
            ),
            TextFormField(
              validator: isValid,
              decoration: InputDecoration(
                hintText: "Nome do jogo"
              ),
              onSaved: (String value ){
                _nome = value;
              }
            ),
            TextFormField(
              maxLines: null,
              validator: isValid,
              decoration: InputDecoration(
                hintText: "Descrição"
              ),
              onSaved: (String value ){
                _descricao = value;
              }
            ),
          ])
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: isLoading == null ? FlatButton.icon(
              label: Text("Adicionar imagem"),
              icon: Icon(
                Icons.image,
                size: 50.0,
                ),
              onPressed: getImage,
              color: Colors.transparent,
            ) : isLoading ? CircularProgressIndicator() 
            : FlatButton.icon(
              label: Text("Adicionar imagem"),
              icon: Icon(
                Icons.image,
                size: 50.0,
                ),
              onPressed: getImage,
              color: Colors.transparent,
            )
          ),
          Divider(height: 30.0,),
          Container(
            alignment: Alignment.centerLeft,
            child: isLoading == null ? FlatButton.icon(
              label: Text("Tirar foto"),
              icon: Icon(
                Icons.camera_alt,
                size: 50.0,
                ),
              onPressed: takePhoto,
              color: Colors.transparent,
            ) : isLoading ? CircularProgressIndicator() 
            : FlatButton.icon(
              label: Text("Tirar foto"),
              icon: Icon(
                Icons.camera_alt,
                size: 50.0,
                ),
              onPressed: takePhoto,
              color: Colors.transparent,
            )
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            color: Colors.pink,
            child: Text("Criar"),
            onPressed: () {
                final form = _formKey.currentState;
                if(form.validate() && !isLoading) {
                  form.save();
                  Firestore.instance.collection("events").add(
                    {
                      "userId": _prefs.getString('id'),
                      "nomeUsuario": _prefs.getString('nickname'),
                      "local": _local,
                      "nome": _nome,
                      "titulo": _title,
                      "descricao": _descricao,
                      "imageUrl": imageUrl
                    }
                  );
                  Navigator.pop(context);
                }
            },
          )
        ],)
      ),
    ));
  }

  String isValid(String text) {
    if(text.isEmpty || text == null){
      return "Precisa preencher este campo";
    } else {
      return null;
    }
  }


  Future getImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future takePhoto() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }


  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      print('This file is not an image');
    });
  }

}
