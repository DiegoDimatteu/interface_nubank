import 'package:flutter/material.dart';
import 'package:nubank/pages/home/widgets/card_app.dart';

class PageViewApp extends StatelessWidget {
  final double top;
  final ValueChanged<int> onChanged;
  final GestureDragUpdateCallback onPanUpdate;
  final bool showMenu;

  const PageViewApp(
      {Key? key,
      required this.top,
      required this.onChanged,
      required this.onPanUpdate,
      required this.showMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(microseconds: 100),
      curve: Curves.easeOut,
      top: top,
      height: MediaQuery.of(context).size.height * .52,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: GestureDetector(
          onPanUpdate: onPanUpdate,
          child: PageView(
            onPageChanged: onChanged,
            physics: showMenu
                ? NeverScrollableScrollPhysics()
                : BouncingScrollPhysics(),
            children: const [
              CardApp(),
              CardApp(),
              CardApp(),
            ],
          ),
        ),
      ),
    );
  }
}
