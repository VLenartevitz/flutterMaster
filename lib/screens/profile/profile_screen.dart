import 'package:billx/controllers/auth_controller.dart';
import 'package:billx/controllers/user_controller.dart';
import 'package:billx/screens/calendar/calendar_screen.dart';
import '../../controllers/bill_controller.dart';
import '../home/home_screen.dart';
import '../../commons/formatters/cpf_input_formatter.dart';
import '../../commons/formatters/date_input_formatter.dart';
import '../../controllers/register_controller.dart';
import '../../models/user_model.dart';
import '../../services/di.dart';
import '../login/login_screen.dart';
import 'widgets/input_perfil_widget.dart';
import 'package:flutter/material.dart';
import '../../commons/app_colors.dart';
import '../../widgets/app_btn.dart';
import 'package:intl/intl.dart';


//principal funcionalidade da tela é alterar o name no BD atraves do input "Como quer que a gente te chame"
//em outros inputs somente a visualição não sendo alterado os valores
//em algumas partes da tela é pego dados da model do usuario logado

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authController = DI.resolve(AuthController());
  final _controller = DI.resolve(RegisterController());
  final _userController = DI.resolve(UserController());
  final formValidVN = ValueNotifier<bool>(false);
  final _usernameInput = TextEditingController(text: '');
  final _phoneInput = TextEditingController(text: '');
  final _emailInput = TextEditingController(text: '');
  int _selectedIndex = 2;
  late UserModel user;

  @override
  void dispose() {
    _usernameInput.dispose();
    _phoneInput.dispose();
    _emailInput.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    user = authController.authModel.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandPurple,
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
                    size: 100,
                  ),
                  SizedBox(width: 100),
                  Icon(
                    Icons.notifications,
                    color: AppColors.white,
                    size: 35,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(40.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                  ),
                  color: AppColors.white
                ),
                child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                    const Row(
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: AppColors.brandPurple,
                          size: 30,
                        ),
                        Text(
                            "Seu Perfil",
                          style: TextStyle(
                            color: AppColors.brandPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  const SizedBox( height: 20,),
                   Text(
                   user.name,
                    style: const TextStyle(
                      fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:[
                          const Icon(
                            Icons.copy,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            user.email,
                            style: const TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ]
                      ),
                      const Icon(
                        Icons.question_mark_sharp,
                            color: AppColors.neutral,
                        size: 22,
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "DOCUMENTOS",
                    style: TextStyle(
                      color: AppColors.brandPurple,
                        fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                     padding: const EdgeInsets.only(
                       top: 20.0,
                       bottom: 15.0,
                       left: 25.0,
                       right: 20.0,
                     ),
                     decoration: BoxDecoration(
                         color: AppColors.gray,
                         borderRadius: BorderRadius.circular(16.0)
                     ),
                     child: const Column(
                       children: [
                         Text(
                           'Antes de efetuar qualquer transação, você precisa validar seu cadastro com a gente!',
                           style: TextStyle(
                               fontSize: 17.0,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         SizedBox(height: 15.0),
                         Text(
                           'É bem simples e só leva 2 minutos.',
                           style: TextStyle(
                               fontSize: 17.0,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     )
                   ),
                  const SizedBox(height: 20.0),
                  const Row(
                    children: [

                      Icon(
                          Icons.looks_one,
                          color: AppColors.neutral,
                      ),
                      SizedBox(width: 15.0),
                      Expanded(
                          child:Text(
                            "Nos envie um documento com foto",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15
                            ),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  const Row(
                    children: [
                      Icon(
                        Icons.looks_two,
                        color: AppColors.neutral,
                      ),
                      SizedBox(width: 15.0),
                      Expanded(child: Text(
                        "Tire uma selfie segurando o documento",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15
                        ),
                      )
                      ),

                    ],
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandPurple,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(70),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      ),
                      onPressed: () => {},
                      child:
                        const Text(
                          "Começar a validação",
                          style:
                          TextStyle(
                            color: AppColors.light,
                            fontSize: 20
                          ),
                        )
                  ),
                  const SizedBox(height: 50.0),
                  const Text(
                    "SEUS DADOS",
                    style: TextStyle(
                        color: AppColors.brandPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Como quer que a gente te chame?",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          InputPerfilWidget(
                            key: const Key("input.name"),
                            controller: _usernameInput,
                            inputType: TextInputType.name,
                            hint: user.name,
                            msgValidator: "Coloque como voce quer ser chamado",
                          ),
                          const SizedBox(height: 25.0),
                          const Text(
                            "Celular",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          InputPerfilWidget(
                            enabled: false,
                            hint: '(${user.phoneNumber.substring(0, 2)}) ${user.phoneNumber.substring(2, 7)}-${user.phoneNumber.substring(7)}',
    ),

                          const SizedBox(height: 25.0),
                          const Text(
                            "Email",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          InputPerfilWidget(
                            enabled: false,
                            hint: user.email,
                            inputType: TextInputType.emailAddress,
                            inputFormatters: [CpfInputFormatter()],
                          ),
                          const SizedBox(height: 25.0),
                          ValueListenableBuilder(
                              valueListenable: formValidVN,
                              builder: (context, formValid, child){
                                return AppBtn(
                                  textColor:  AppColors.brandPurple ,
                                  text: "Salvar",
                                  bgColor: AppColors.gray,
                                  onPressed: () {
                                    if (_usernameInput.text != _controller.form.value['name']) {
                                      _userController.updateProfileData(_usernameInput.text);
                                    }
                                  },
                                );
                              }
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 50.0),
                  const Text(
                    "OUTRAS INFORMAÇÕES",
                    style: TextStyle(
                        color: AppColors.brandPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    "Nome Completo",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  InputPerfilWidget(
                    enabled: false,
                    hint: user.name,
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    "CPF",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  InputPerfilWidget(
                    enabled: true,
                    hint: '${user.cpf.substring(0, 3)}.${user.cpf.substring(3, 6)}.${user.cpf.substring(6, 9)}-${user.cpf.substring(9)}',
                    inputType: TextInputType.number,
                    inputFormatters: [CpfInputFormatter()],
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    "Data de Nascimento",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  InputPerfilWidget(
                    enabled: true,
                    hint: DateFormat('dd/MM/yyyy').format(user.birthday!),
                    inputType: TextInputType.datetime,
                    inputFormatters: [DateInputFormatter()],

                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    "Nome da Mãe",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  InputPerfilWidget(
                    enabled: false,
                    hint: user.firstName,
                  ),
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

