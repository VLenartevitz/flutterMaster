import 'package:flutter/material.dart';

import '../../commons/font_family.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../controllers/register_controller.dart';
import '../../commons/app_colors.dart';
import '../../helpers/password.dart';
import '../../services/di.dart';
import '../../widgets/app_back_btn.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_btn.dart';
import '../screen.dart';

class RegisterPasswordScreen extends StatefulWidget {
  const RegisterPasswordScreen({super.key});

  @override
  State<RegisterPasswordScreen> createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DI.resolve(RegisterController());
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
    return Screen(
      isLoading: _controller.isLoading,
      appBar: AppBar(leading: const AppBackBtn()),
      formKey: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Para finalizar seu cadastro, informe uma senha",
                style: TextStyle(
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(238, 242, 246, 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Sua senha deve conter 8 dígitos, uma letra maiúscula, \numa letra minúscula, um número e um caractere especial.",
                  style: TextStyle(
                    fontFamily: FontFamily.appFont,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              AppInput(
                controller: _passwordInput,
                autoFocus: true,
                passwordVisible: false,
                inputType: TextInputType.visiblePassword,
                hint: "Digite a senha",
                labelText: 'Senha',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                msgValidator: "Informe a senha.",
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: _confirmPasswordInput,
                inputType: TextInputType.visiblePassword,
                passwordVisible: false,
                hint: "Digite a senha novamente",
                labelText: 'Confirme a senha',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                msgValidator: "Informe a senha.",
              ),
            ],
          ),
          AppValueListenableBuilder(
            valueListenables: [_passwordInput, _confirmPasswordInput],
            builder: (_) {
              return AppBtn(
                textColor: AppColors.white,
                text: 'Cadastrar',
                bgColor: AppColors.primary,
                onPressed: (Password.isInvalid(_passwordInput.text) || Password.isInvalid(_confirmPasswordInput.text))
                           || (_passwordInput.text != _confirmPasswordInput.text)
                        ? null : () {
                            if (_formKey.currentState!.validate()) {
                              _controller.form.value['password'] = _passwordInput.text;
                              _controller.form.value['password_confirmation'] = _confirmPasswordInput.text;

                              _controller.register();
                            }
                          },
              );
            },
          ),
        ],
      ),
    );
  }
}
