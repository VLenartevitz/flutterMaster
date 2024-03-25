import 'package:billx/screens/calendar/calendar_screen.dart';
import 'package:billx/widgets/header_component.dart';
import '../login/login_screen.dart';
import '../profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../commons/app_colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandPurple,
      body: HeaderComponent(),

      bottomNavigationBar: BottomNavigationBar(
        key: const Key("navigationbar"),
        backgroundColor: Colors.white,
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.toc_outlined, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.toc_outlined, color: AppColors.brandBlue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.calendar_today_outlined, color:  AppColors.brandBlue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.person, color:  AppColors.brandBlue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.settings, color:  AppColors.brandBlue),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CalendarScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          break;
      }}
    );
  }
}
