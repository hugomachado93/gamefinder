import 'package:app2/tabs/eventstab.dart';
import 'package:app2/tabs/friendstab.dart';
import 'package:app2/tabs/hometab.dart';
import 'package:app2/tabs/myevent.dart';
import 'package:app2/tabs/procurajogos.dart';
import 'package:app2/widgets/customdrawer.dart';
import 'package:app2/widgets/floatingbutton.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final String _id;

  final _pageController = PageController();

  HomeScreen(this._id);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Eventos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: EventTab(),
          floatingActionButton: FloatButtonWidget(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Conversas"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: FriendsTab(_id),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Eventos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: MyEvent(_id),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Grupos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProcuraJogos(_id),
        )
      ],
    );
  }

}