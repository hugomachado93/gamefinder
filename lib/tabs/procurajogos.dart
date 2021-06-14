
import 'dart:convert';

import 'package:app2/boardgame.dart';
import 'package:app2/tabs/jogostab.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProcuraJogos extends StatefulWidget {

  final String _id;

  ProcuraJogos(this._id);

  @override
  _ProcuraJogosEvent createState() => _ProcuraJogosEvent(_id);

}

class _ProcuraJogosEvent extends State<ProcuraJogos> {

  final String _id;
  String _clientId = "egbgSkgRSg";
  final _procuraController = TextEditingController();

  _ProcuraJogosEvent(this._id);

  Future<BoardGame> fetchPost(String nomeDoJogo) async {

    String result = nomeDoJogo.replaceAll(RegExp(' +'), '%20');

    final response =
        await http.get('https://www.boardgameatlas.com/api/search?name=$result&pretty=true&client_id=$_clientId');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return BoardGame.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.lightBlueAccent,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(color: Colors.blueAccent, width: 3.0)
            ),
            child: TextField(
              onChanged: (text) {

              },
              style: TextStyle(fontSize: 25.0),
              controller: _procuraController,
              decoration: InputDecoration(
                hintText: "     Procurar...",
                border: InputBorder.none
              ),
            ),
          ),
          Divider(color: Colors.black,),
          FutureBuilder<BoardGame>(
            future: fetchPost(_procuraController.text),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Flexible(
                  child: Container(
                    child: GridView.builder(
                      itemCount: snapshot.data.games.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: 
                          GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => JogosTab(snapshot.data.games[index])));
                          },
                          child: GridTile(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue,
                              width: 7.0),
                              image: DecorationImage( image: NetworkImage(snapshot.data.games[index].thumbUrl),
                              )         
                            ),
                          ),
                        )));
                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

}