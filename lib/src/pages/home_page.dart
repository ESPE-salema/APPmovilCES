import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/utils/main_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: homeWidgets[currentTab],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            currentTab = index;
            setState(() {});
          },
          currentIndex: currentTab,
          type: BottomNavigationBarType.fixed,
          items: menuOptions
              .map((e) =>
                  BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
              .toList(),
        ),
      ),
    );
  }
}

/*class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: homeWidgets[mainProvider.index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            mainProvider.index = index;
          },
          currentIndex: mainProvider.index,
          type: BottomNavigationBarType.fixed,
          items: menuOptions
              .map((e) =>
                  BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
              .toList(),
        ),
      ),
    );
  }
}*/
