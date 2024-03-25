import 'package:billx/widgets/header_component.dart';

import '../../commons/app_colors.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../controllers/login_controller.dart';
import '../../services/di.dart';
import '../../widgets/app_list_bills.dart';

import 'package:flutter/material.dart';

/*
 * Screen that lists to due, late and paid bills ordered by due or paid date
 * It should use BillsController to get those bills by the user logged in which is why we also inject LoginController
 * It uses headerComponent, AppListBills and bottomNavigationBar
 *
 * @TODO: Layout ajudsments according to Figma
 * @TODO: request API through controller to get bills list
 */
class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _controller = DI.resolve(LoginController());

  // This is mocked until we got the info through BillsController
  String mockJsonString = '''
    {
        "data": [
            {
              "id": 1,
              "company_name": "Claro",
              "company_logo": "path/to/logo.png",
              "value": "100.00",
              "due_date": "2024-02-15",
              "status": "NP",
              "description": "email"
            },
            {
              "id": 2,
              "company_name": "Vivo",
              "company_logo": "path/to/logo.png",
              "value": "250.00",
              "due_date": "2024-02-15",
              "status": "PG",
              "description": "email"
            },
        ],
        "links": {
            "first": "http://localhost/api/bills?page=1",
            "last": null,
            "prev": null,
            "next": null
        },
        "meta": {
            "current_page": 1,
            "from": null,
            "path": "http://localhost/api/bills",
            "per_page": 15,
            "to": null
        }
    }
  ''';

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
                // const HeaderComponent(),
                AppListBills(accountsJson: mockJsonString, typeList: 'toPay'),
              ]
          )
      ),
      // @TODO: turn this bottom navigation bar into a cohesive widget (right now we should mount this in every screen we're using
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
            activeIcon: Icon(Icons.toc_outlined, color: AppColors.brandPurple),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.calendar_today_outlined, color:  AppColors.brandPurple),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.person, color:  AppColors.brandPurple),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.settings, color:  AppColors.brandPurple),
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
            MaterialPageRoute(builder: (context) => const BillsScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
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
