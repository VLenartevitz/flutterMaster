import 'package:flutter/material.dart';

import '../../commons/font_family.dart';
import '../../commons/app_colors.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../controllers/register_controller.dart';
import '../../helpers/email.dart';
import '../../services/di.dart';
import '../../widgets/app_back_btn.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';
import '../../widgets/app_btn.dart';

class RegisterEmailScreen extends StatefulWidget {
  const RegisterEmailScreen({super.key});

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailInput = TextEditingController();
  final _confirmEmailInput = TextEditingController();
  final _controller = DI.resolve(RegisterController());

  @override
  void dispose() {
    _emailInput.dispose();
    _confirmEmailInput.dispose();
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
                "Estamos quase lá!",
                style: TextStyle(
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Agora nos informe um e-mail \nao qual você tenha acesso",
                style: TextStyle(
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: _emailInput,
                autoFocus: true,
                inputType: TextInputType.emailAddress,
                hint: "Digite seu e-mail",
                labelText: 'E-mail',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                msgValidator: "Informe o seu e-mail.",
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: _confirmEmailInput,
                inputType: TextInputType.emailAddress,
                hint: "Digite seu e-mail novamente",
                labelText: 'Confirme seu e-mail',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                msgValidator: "Informe o seu e-mail.",
              ),
            ],
          ),
          AppValueListenableBuilder(
            valueListenables: [_emailInput, _confirmEmailInput],
            builder: (_) {
              return AppBtn(
                textColor: AppColors.white,
                text: 'Continuar',
                bgColor: AppColors.primary,
                onPressed: (Email.isInvalid(_emailInput.text) || Email.isInvalid(_confirmEmailInput.text)) ||
                    (_emailInput.text != _confirmEmailInput.text)
                    ? null : () {
                        if (_formKey.currentState!.validate()) {
                          _controller.form.value['email'] = _emailInput.text;
                          _controller.form.value['email_confirmation'] = _confirmEmailInput.text;

                          _controller.saveEmail();
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
