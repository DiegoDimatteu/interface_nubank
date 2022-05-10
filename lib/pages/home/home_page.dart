import 'package:flutter/material.dart';
import 'package:nubank/pages/home/widgets/item_menu_bottom.dart';
import 'package:nubank/pages/home/widgets/menu_app.dart';
import 'package:nubank/pages/home/widgets/my_app_bar.dart';
import 'package:nubank/pages/home/widgets/my_dots_app.dart';
import 'package:nubank/pages/home/widgets/page_view_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _showMenu;
  late int _currentIndex;
  late double _yPosition;

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
    _yPosition = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    if (_yPosition == 0.0) {
      _yPosition = _screenHeight * .18;
    }

    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
                _yPosition =
                    _showMenu ? _screenHeight * .85 : _screenHeight * .18;
              });
            },
          ),
          MenuApp(
            top: _screenHeight * .22,
            showMenu: _showMenu,
          ),
          PageViewApp(
            showMenu: _showMenu,
            top: _yPosition,
            //!_showMenu ? _screenHeight * .18 : _screenHeight * .75,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            onPanUpdate: (details) {
              double positionBottomLimit = _screenHeight * .85;
              double positionTopLimit = _screenHeight * .18;
              double middlePosition = positionBottomLimit - positionTopLimit;
              middlePosition = middlePosition / 2;

              setState(() {
                _yPosition += details.delta.dy;

                _yPosition = _yPosition < positionTopLimit
                    ? positionTopLimit
                    : _yPosition;

                _yPosition = _yPosition > positionBottomLimit
                    ? positionBottomLimit
                    : _yPosition;

                if (_yPosition != positionBottomLimit && details.delta.dy > 0) {
                  _yPosition =
                      _yPosition > positionTopLimit + middlePosition - 75
                          ? positionBottomLimit
                          : _yPosition;
                } else if (_yPosition != positionTopLimit &&
                    details.delta.dy < 0) {
                  _yPosition = _yPosition < positionBottomLimit - middlePosition
                      ? positionTopLimit
                      : _yPosition;
                }

                if (_yPosition == positionBottomLimit) {
                  _showMenu = true;
                } else if (_yPosition == positionTopLimit) {
                  _showMenu = false;
                }
              });
            },
          ),
          MyDotsApp(
            showMenu: _showMenu,
            top: _screenHeight * .70,
            currentIndex: _currentIndex,
          ),
          AnimatedPositioned(
            duration: const Duration(microseconds: 200),
            bottom: !_showMenu ? 35 : 0,
            left: 0,
            right: 0,
            height: _screenHeight * 0.14,
            child: AnimatedOpacity(
              duration: const Duration(microseconds: 200),
              opacity: !_showMenu ? 1 : 0,
              child: Container(
                //color: Colors.red,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                    ItemMenuBottom(
                        icon: Icons.person_add, text: 'Indicar Amigos'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
