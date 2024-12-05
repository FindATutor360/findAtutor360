import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/views/main/cart/cart_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:findatutor360/views/main/message/message_view.dart';
import 'package:findatutor360/views/main/settings/settings_view.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:iconsax/iconsax.dart';

class ParentView extends StatefulWidget {
  const ParentView({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;
  static const route = '/dashboard';

  @override
  State<ParentView> createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  final String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(222, 224, 227, 1),
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (i) => onPageChange(i, context),
        type: BottomNavigationBarType.shifting,
        selectedItemColor: const Color.fromRGBO(4, 118, 175, 1),
        unselectedItemColor: const Color.fromRGBO(121, 132, 142, 1),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(4, 128, 181, 1)),
        iconSize: 26,
        selectedFontSize: 10,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Home',
              activeIcon: Icon(Iconsax.home_15),
              tooltip: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Iconsax.shop),
              label: 'Shop',
              activeIcon: Icon(Iconsax.shop5),
              tooltip: 'Buy books and more'),
          BottomNavigationBarItem(
            icon: StreamBuilder<List<Map<String, dynamic>>>(
              stream: MessageController().getLatestMessages(currentUserEmail!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return const Icon(Iconsax.sms); // Handle error gracefully
                }

                // Extract and sum unreadCount from the list
                final messages = snapshot.data!;
                final int unreadCount = messages.fold<int>(
                  0,
                  (total, message) =>
                      total + (message['unreadCount'] as int? ?? 0),
                );

                return Badge(
                  label: Text(
                    unreadCount > 0 ? unreadCount.toString() : '0',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  backgroundColor: const Color.fromRGBO(252, 57, 46, 1),
                  isLabelVisible: unreadCount > 0, // Hide badge when count is 0
                  child: const Icon(Iconsax.sms),
                );
              },
            ),
            label: 'Message',
            activeIcon: const Icon(Iconsax.sms5),
            tooltip: 'Chat with tutors',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Iconsax.shopping_cart),
              label: 'Cart',
              activeIcon: Icon(Iconsax.shopping_cart5),
              tooltip: 'View your cart'),
          const BottomNavigationBarItem(
              icon: Icon(Iconsax.setting),
              label: 'Settings',
              activeIcon: Icon(Iconsax.setting5),
              tooltip: 'Profile Settings'),
        ],
      ),
    );
  }

  void onPageChange(
    int page,
    BuildContext context,
  ) {
    final routes = [
      HomeView.path,
      ShopView.path,
      MessageView.path,
      CartView.path,
      SettingsView.path,
    ];

    final currentRoute = routes[page];

    GoRouter.of(context).go(currentRoute);
  }
}
