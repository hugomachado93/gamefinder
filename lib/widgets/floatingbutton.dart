import 'package:app2/tabs/createevent.dart';
import 'package:flutter/material.dart';

class FloatButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen()));
      },
    );
  }
}