import 'package:flutter/material.dart';
import 'package:pregacare/chat_screen.dart';
import 'package:pregacare/home_screen.dart';
import 'package:pregacare/widgets/home/bottom_bar/contacts_screen.dart';
import 'package:pregacare/widgets/home/bottom_bar/profile_screen.dart';
import 'package:pregacare/widgets/home/bottom_bar/calendar_screen.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ContactsScreen(),
    CalendarScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'Calender',
              icon: Icon(
                Icons.calendar_month_rounded,
              )),
          BottomNavigationBarItem(
              label: 'AI Chat',
              icon: Icon(
                Icons.mark_unread_chat_alt_rounded,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
              )),
        ],
      ),
    );
  }
}
