import 'package:flutter/material.dart';
import 'package:gearup/pages/navpages/bar_item_page.dart';
import 'package:gearup/pages/navpages/home_page.dart';
import 'package:gearup/pages/navpages/my_page.dart';
import 'package:gearup/pages/navpages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    BarItemPage(),
    SearchPage(),
    MyPage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[0],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.green.shade600,
          unselectedItemColor: Colors.black54.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                title: Text("Home"), icon: Icon(Icons.apps)),
            BottomNavigationBarItem(
                title: Text("Bar"), icon: Icon(Icons.bar_chart_sharp)),
            BottomNavigationBarItem(
                title: Text("Search"), icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                title: Text("My"), icon: Icon(Icons.person)),
          ]),
    );
  }
}
