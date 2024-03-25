import 'package:flutter/material.dart';

import '../../extensions/app_extensions.dart';
import '../../commons/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/sizes.dart';
import '../../widgets/listen.dart';
import 'login_btn.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordVisible = true.listen;
  final _confirmPasswordVisible = true.listen;
  final _passwordInput = TextEditingController();
  final _confirmPasswordInput = TextEditingController();

  @override
  void dispose() {
    _passwordInput.dispose();
    _confirmPasswordInput.dispose();

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
          AppRoutes.changePassword.name,
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
                      "Adicione uma nova senha.",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "Com no mínimo 8 caracteres.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Listen(() {
                            return TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _passwordInput,
                              obscureText: !_passwordVisible.value,
                              autofocus: true,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _passwordVisible.value = !_passwordVisible.value;
                                  },
                                  icon: Icon(
                                    !_passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe sua senha.';
                                }
                                return null;
                              },
                            );
                          }),
                          const SizedBox(height: 25),
                          Listen(() {
                            return TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _confirmPasswordInput,
                              obscureText: !_confirmPasswordVisible.value,
                              autofocus: true,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Confirme a senha',
                                labelStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _confirmPasswordVisible.value = !_confirmPasswordVisible.value;
                                  },
                                  icon: Icon(
                                    !_confirmPasswordVisible.value ?
                                    Icons.visibility :
                                    Icons.visibility_off,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirme a senha.';
                                }
                                return null;
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: LoginBtn(
                    textColor: AppColors.white,
                    text: 'Alterar senha',
                    bgColor: AppColors.primary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppRoutes.home.redirect();
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
