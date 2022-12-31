// import 'package:findatutor360/constants/icon/index.dart';
import 'package:flutter/material.dart';
import 'package:findatutor360/views/main/cart/cart_view.dart';
import 'package:findatutor360/views/main/message/message_view.dart';
import 'package:findatutor360/views/main/settings/settings_view.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:badges/badges.dart';

class ParentView extends StatefulWidget {
  const ParentView({Key? key}) : super(key: key);

  @override
  State<ParentView> createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  int _currentIndex = 0;
  final List<Widget> _views = const [
    HomeView(),
    ShopView(),
    MessageView(),
    CartView(),
    SettingsView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(222, 224, 227, 1),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        selectedItemColor: const Color.fromRGBO(4, 118, 175, 1),
        unselectedItemColor: const Color.fromRGBO(121, 132, 142, 1),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.roofing_outlined, size: 30),
              label: 'Home',
              activeIcon: Icon(Icons.roofing_rounded, size: 30),
              tooltip: 'HomeView'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined, size: 30),
              label: 'Shop',
              activeIcon: Icon(Icons.storefront_rounded, size: 30),
              tooltip: 'Buy books and more'),
          BottomNavigationBarItem(
              icon: Badge(
                  position: const BadgePosition(top: -5, end: -2),
                  badgeContent: const Text('1',
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                  badgeColor: const Color.fromRGBO(252, 57, 46, 1),
                  child: const Icon(Icons.mail_outlined, size: 30)),
              label: 'Message',
              activeIcon: const Icon(Icons.mail_rounded, size: 30),
              tooltip: 'Chat with tutors'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 30),
              label: 'Cart',
              activeIcon: Icon(Icons.shopping_cart_rounded, size: 30),
              tooltip: 'View your cart'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: 30),
              label: 'Settings',
              activeIcon: Icon(Icons.settings_rounded, size: 30),
              tooltip: 'Profile Settings'),
        ],
      ),
    );
  }
}
