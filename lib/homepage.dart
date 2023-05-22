import 'package:college_project/Screens/ChatScreen.dart';
import 'package:college_project/Screens/HomeScreen.dart';
/*
import 'package:college_project/Screens/ChatMainScreen.dart';
*/
import 'package:college_project/Screens/create.dart';
import 'package:college_project/Screens/explore.dart';
import 'package:college_project/Screens/profile_screen.dart';
import 'package:college_project/api/apis.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(),
          Explore(),
          //Container(color: Colors.red),
          const CreateCapture(),
          const ChatScreen(),
          ProfileScreen(user: APIs.me),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          const BottomBarItem(
            icon: Icon(Icons.search_rounded),
            title: Text('Search'),
            activeColor: Colors.red,
          ),
          BottomBarItem(
            icon: const Icon(Icons.add_box),
            title: const Text('Create'),
            backgroundColorOpacity: 0.1,
            activeColor: Colors.greenAccent.shade700,
          ),
          const BottomBarItem(
            icon: Icon(Icons.message_rounded),
            title: Text("Chat"),
            activeColor: Colors.pinkAccent,
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            activeColor: Colors.orange,
            activeIconColor: Colors.orange.shade600,
            activeTitleColor: Colors.orange.shade700,
          ),
        ],
      ),
    );
  }
}
