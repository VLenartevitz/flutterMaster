import '../../controllers/bill_controller.dart';
import '../../controllers/faq_controller.dart';
import '../../models/bill_model.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';

import '../../controllers/auth_controller.dart';
import '../../services/di.dart';
import '../../widgets/app_list_item.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import '../profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../commons/app_colors.dart';

// CalendarScreen tem um cabeçalho com foto, ícone de notificacoes sem interação e logo abaixo o ShowOver
// ShowOver mexe com o componente 'olho'
//SHowOverSate é o estado do ShowOver para esconder e interagir o 'olho'
//Principal funcionamento da tela é o componente do Calendario
//import 'package:calendar_date_picker2/calendar_date_picker2.dart'; biblioteca usada para construção do calendario
// ao clicar na data, requisição para trazer as contas do dia selecionado (start e end date são iguais)
// embaixo do calendario utilizando o import '../../widgets/app_list_item.dart'; tras a listagem das contas do dia clicado no calendario
// @todo alteração nos dias que tem contas no calendario
// @todo visualizar retorno correto da api
// @todo fazer a listagem, corrigir quebra na tela

class ShowOver extends StatefulWidget {
  const ShowOver({super.key});

  @override
  _ShowOverState createState() => _ShowOverState();
}

class _ShowOverState extends State<ShowOver> {
  bool _obscureIcon = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key("ShowOverWidget"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            _obscureIcon ? Icons.remove_red_eye_outlined : Icons.visibility_off,
            color: AppColors.white,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              _obscureIcon = !_obscureIcon;
            });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_obscureIcon)
              const Text(
                "Saldo Atual",
                style: TextStyle(color: AppColors.white),
              ),
            if (!_obscureIcon)
              const Text(
                "Seu Saldo",
                style: TextStyle(color: AppColors.white),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "R\$",
                  style: TextStyle(fontSize: 13, color: AppColors.white),
                ),
                const SizedBox(width: 5),
                if (_obscureIcon)
                  const Text(
                    "3.420,00",
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                if (!_obscureIcon)
                  const Text(
                    "****",
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
              ],
            )
          ],
        ),
        const SizedBox(width: 10),
        if (_obscureIcon)
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.darker),
              ),
              onPressed: () {},
              child: const Text(
                "Adic. Saldo",
                style: TextStyle(color: AppColors.light),
              ))
      ],
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  BillModel? billModel;
  final faqController = DI.resolve(FaqController());
  final authController = DI.resolve(AuthController());
  final billController = DI.resolve(BillController());
  int _selectedIndex = 1;
  final bool condition = false;
  late List<DateTime?> _selectedDate = [
    DateTime.now(),
  ];
  late List<DateTime?> selectedDate = [
    DateTime.now(),
  ];

  _onDateSelected(dates) {
    setState(() => _selectedDate = dates);
    selectedDate = _selectedDate;
    billController.get(authController.authModel.user.id, selectedDate);
    print(billController.bills.data);
  }

  @override
  void initState() {
    super.initState();
    billController.get(authController.authModel.user.id, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_sharp,
                  color: AppColors.white,
                  size: 40,
                ),
                SizedBox(width: 100),
                Icon(
                  Icons.notifications,
                  color: AppColors.white,
                  size: 40,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(25.0),
              child: const ShowOver(),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: AppColors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CalendarDatePicker2(
                    key: const Key("CalendarWidget"),
                    config: CalendarDatePicker2Config(
                        dayBuilder: (
                            {
                              required date,
                              decoration,
                              isDisabled,
                              isSelected,
                              isToday,
                              textStyle}) {
                          Widget? dayWidget;
                          bool isBeforeToday = date.isBefore(DateTime.now());
                          //Widget personalizado para mostrar os dias em vermelho ou verde
                          if (date.day % 2 == 0 && date.day % 3 != 0) {
                            dayWidget = Container(
                              decoration: decoration,
                              child: Center(
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Text(
                                      MaterialLocalizations.of(context)
                                          .formatDecimal(date.day),
                                      style: textStyle
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 27.5),
                                      child: Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: isBeforeToday ? Colors.red : Colors.green,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                              ),

                            );
                          }
                          return dayWidget;
                        },

                        centerAlignModePicker: true,
                        selectedDayTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        selectedDayHighlightColor: AppColors.black,
                        dayBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0),
                            bottomLeft: Radius.circular(18.0)),
                        customModePickerIcon: const SizedBox(),
                        dayTextStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        weekdayLabelTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        controlsTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.darker)),
                    value: _selectedDate,
                    onValueChanged: (dates) {
                      return _onDateSelected(dates);
                    },
                  ),
                  const Divider(
                  ),
                  Text(
                    '$_selectedDate',
                    style: const TextStyle(fontSize: 24),
                  ),

                  // AppListItem(
                  //   title: billController.bills.,
                  //   value: '100,00',
                  //   description: "email",
                  //   dueDate: DateTime(2024, 2, 27),
                  //   icon: '100,00',
                  //   status: 'NP',
                  //   onPressed: () {
                  //     print('Card clicado!');
                  //   },
                  // ),

                ],
              ),
            ),
          ],
        ),
      ),
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
            activeIcon:
                Icon(Icons.calendar_today_outlined, color: AppColors.brandBlue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.person, color: AppColors.brandBlue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: AppColors.neutral),
            label: '',
            activeIcon: Icon(Icons.settings, color: AppColors.brandBlue),
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
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          break;
      }
    });
  }
}