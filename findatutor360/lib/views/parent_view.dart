// import 'package:findatutor360/constants/icon/index.dart';
import 'package:flutter/material.dart';
import 'package:findatutor360/views/main/cart/cart_view.dart';
import 'package:findatutor360/views/main/message/message_view.dart';
import 'package:findatutor360/views/main/settings/settings_view.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';

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
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: const Color.fromARGB(255, 197, 193, 193),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30),
              label: 'Home',
              tooltip: 'HomeView'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shop_2_outlined, size: 30),
              label: 'Shop',
              tooltip: 'Buy books and more'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined, size: 30),
              label: 'Message',
              tooltip: 'Chat with tutors'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 30),
              label: 'Cart',
              tooltip: 'View your cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: 30),
              label: 'Settings',
              tooltip: 'Profile Settings'),
        ],
      ),
    );
  }
}
