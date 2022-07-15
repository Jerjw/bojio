import 'package:bojio/screens/chat_screen.dart';
import 'package:bojio/screens/events_screen.dart';
import 'package:bojio/screens/notif_screen.dart';
import 'package:bojio/screens/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [
    EventsScreen(),
    ChatScreen(),
    NotifsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bojio'),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
              backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_available),
              label: 'Notifications',
              backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pink,
          )
        ],
      ),
    );
  }
}


