import 'package:app2/tiles/drawertile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class CustomDrawer extends StatelessWidget {

  final PageController _pageController;

  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Colors.blue
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 40.0),
            children: <Widget>[
              Container(
                height: 200.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 60.0,
                      left: 0.0,
                      child: Text(
                        "Menu",
                        style: TextStyle(fontSize: 30.0),
                      ),
                      
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Ola,"),
                          GestureDetector(
                            child: Text(
                              "Deslogar",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor
                              ),
                              ),
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.clear();
                              await FirebaseAuth.instance.signOut();
                              await GoogleSignIn().signOut();
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyApp()),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", _pageController, 0),
              DrawerTile(Icons.list, "Eventos", _pageController, 1),
              DrawerTile(Icons.account_box, "Amigos", _pageController, 2),
              DrawerTile(Icons.event, "Meus Eventos", _pageController, 3),
              DrawerTile(Icons.group_add, "Procurar jogos", _pageController, 4)
            ],
          )
        ],
      ),
    );
  }

}