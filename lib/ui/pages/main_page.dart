import 'package:epasys_app/shared/theme.dart';
import 'package:epasys_app/ui/pages/account/account_page.dart';
import 'package:epasys_app/ui/pages/home_page.dart';
import 'package:epasys_app/ui/pages/broadcast/broadcast_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const BroadcastPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: greyColor2,
            ),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: whiteColor,
          onTap: _onItemTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/ic_home.png',
                width: 24,
              ),
              activeIcon: Image.asset(
                'assets/images/ic_home_active.png',
                width: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/ic_vechile.png',
                width: 24,
              ),
              activeIcon: Image.asset(
                'assets/images/ic_vechile_active.png',
                width: 24,
              ),
              label: 'Broadcast',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/ic_profile.png',
                width: 24,
              ),
              activeIcon: Image.asset(
                'assets/images/ic_profile_active.png',
                width: 24,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      // IndexedStack(
      //   index: _currentIndex,
      //   children: _widgetOptions,
      // ),
    );
  }
}
