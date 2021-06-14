import 'package:app2/boardgame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JogosTab extends StatelessWidget {

  Game _gameInfo;

  JogosTab(this._gameInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gameInfo.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.amber],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                  )
                ),
          child: Stack(
            children: <Widget>[
              Column(children: <Widget>[
              Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(_gameInfo.thumbUrl)),
                  border: Border.all(color: Colors.black, width: 3.0)
                ),
              ),
              Divider(height: 30.0,),
              SizedBox(height: 20,),
              Text(_gameInfo.descriptionPreview),
              Divider(height: 30.0,),
              _gameInfo.yearPublished != null ? Text("Ano: " + _gameInfo.yearPublished.toString()):Container(),
              _gameInfo.minPlayers != null ? Text("Numero minimo de jogadores: " + _gameInfo.minPlayers.toString()): Container(),
              _gameInfo.maxPlayers != null ? Text("Numero maximo de jogadores: " + _gameInfo.maxPlayers.toString()): Container(),
              _gameInfo.maxPlaytime != null ? Text("Tempo maximo de jogo: " + _gameInfo.maxPlaytime.toString()): Container(),
              _gameInfo.minPlaytime != null ? Text("Tempo minimo de jogo: " + _gameInfo.minPlaytime.toString()): Container(),
              _gameInfo.price != null ? Text("Preco medio do produto: " + _gameInfo.price.toString()): Container(),
              _gameInfo.averageUserRating != null ? Text("Nota: "+ _gameInfo.averageUserRating.toString().substring(0, 3) + "/5"): Container(),
            ]),]
          ),
        ),
      ),
    );
  }

}