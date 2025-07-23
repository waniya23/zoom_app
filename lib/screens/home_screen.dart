import 'package:flutter/material.dart';
import 'package:zoom_app/resources/auth_methods.dart';
import 'package:zoom_app/screens/meeting_screen.dart';
import 'package:zoom_app/utils/colors.dart';
import 'package:zoom_app/widgets/custom_button.dart';
import 'package:zoom_app/widgets/home_meeting_button.dart';

import 'history_meeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthMethods _authMethods=AuthMethods();
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
List<Widget> pages=[
  MeetingScreen(),
  HistoryMeetingScreen(),
  const Text('Contacts'),
  CustomButton(text: 'Log Out', onPressed: ()=> AuthMethods().signOut())
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Meet and Chat'),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: "Meet and Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: "Meetings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

        ],
      ),
    );
  }
}

