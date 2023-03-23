import 'package:flutter/material.dart';
import 'package:qaptive_ranjithmenon/firebase/user.dart';
import 'package:qaptive_ranjithmenon/views/home/list.dart';

import 'map.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int selectedIndex = 0;
  List pages = [const MapScreen(), const ListPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackOne'),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.menu),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text('Log Out'),
                    onTap: () {
                      FirebaseUser().logout();
                    },
                  )
                ];
              })
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedItemColor: Colors.redAccent,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'User List'),
          ]),
    );
  }
}
