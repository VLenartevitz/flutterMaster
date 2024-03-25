import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../controllers/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../utils/sizes.dart';
import 'login_btn.dart';

class RecoverPasswordCodeScreen extends StatefulWidget {
  const RecoverPasswordCodeScreen({super.key});

  @override
  State<RecoverPasswordCodeScreen> createState() => _RecoverPasswordCodeScreenState();
}

class _RecoverPasswordCodeScreenState extends State<RecoverPasswordCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final codeInput1 = TextEditingController();
  final codeInput2 = TextEditingController();
  final codeInput3 = TextEditingController();
  final codeInput4 = TextEditingController();
  final codeInput5 = TextEditingController();
  final controller = DI.resolve(LoginController());

  @override
  void dispose() {
    codeInput1.dispose();
    codeInput2.dispose();
    codeInput3.dispose();
    codeInput4.dispose();
    codeInput5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppRoutes.recoverPassword.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          height: AppSizes.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      AppRoutes.recoverPasswordCode.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "Nós enviamos um código de verificação.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        // fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 60,
                            child: TextFormField(
                              controller: codeInput1,
                              autofocus: true,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                  )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 60,
                            child: TextFormField(
                              controller: codeInput2,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 60,
                            child: TextFormField(
                              controller: codeInput3,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 60,
                            child: TextFormField(
                              controller: codeInput4,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 60,
                            child: TextFormField(
                              controller: codeInput5,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Não recebeu o código?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {

                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(AppColors.black),
                          ),
                          child: const Text(
                            "Enviar novamente",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: LoginBtn(
                    textColor: AppColors.white,
                    text: 'Continuar',
                    bgColor: AppColors.primary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppRoutes.changePassword.push();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
