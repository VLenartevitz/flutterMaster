import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/sizes.dart';
import 'login_btn.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameInput = TextEditingController(text: AppRoutes.recoverPassword.arguments);

  @override
  void dispose() {
    usernameInput.dispose();

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
                    const Text(
                      "Preencha o seu usuário.",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: usernameInput,
                        autofocus: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'CPF/CNPJ',
                          labelStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o seu usuário.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: LoginBtn(
                    textColor: AppColors.white,
                    text: 'Recuperar senha',
                    bgColor: AppColors.primary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppRoutes.recoverPasswordCode.push(
                          arguments: usernameInput.text,
                        );
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
