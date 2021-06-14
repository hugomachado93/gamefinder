import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData iconData;
  final String text;
  final PageController _pageController;
  final int page;

  DrawerTile(this.iconData, this.text, this._pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          _pageController.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                size: 32.0,
                color: _pageController.page.round() == page ? 
                Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

}