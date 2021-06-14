import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'myevent.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 2253, 181, 168)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Pagina Pricipal"),
                centerTitle: true,
              )
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("homepage")
              .orderBy("pos").getDocuments(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  );
                } else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    staggeredTiles: snapshot.data.documents.map(
                        (f) => StaggeredTile.count(f.data["x"], f.data["y"])
                    ).toList(),
                    children: snapshot.data.documents.map(
                      (f) {
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: f.data["imageUrl"],
                          fit: BoxFit.cover,
                        );
                      }
                    ).toList(),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }

}