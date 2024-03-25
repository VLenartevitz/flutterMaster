import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../commons/app_icons.dart';
import '../../commons/app_images.dart';
import '../../commons/font_family.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../controllers/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../widgets/app_btn.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameInput = TextEditingController(text: '');
  final _passwordInput = TextEditingController(text: '');
  final _controller = DI.resolve(LoginController());

  @override
  void dispose() {
    _usernameInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      isLoading: _controller.isLoading,
      formKey: _formKey,
      child: Column(
        children: [

          const SizedBox(height: 50),
          Image.asset(AppImages.logo),
          const SizedBox(height: 50),
          const Text(
            "Olá!",
            style: TextStyle(
              color: AppColors.neutral,
              fontFamily: FontFamily.appFont,
              fontWeight: FontWeight.w600,
              height: 1.5,
              fontSize: 20,
            ),
          ),
          const Text(
            "Que bom que está aqui!",
            style: TextStyle(
              color: AppColors.neutral,
              fontFamily: FontFamily.appFont,
              fontWeight: FontWeight.w500,
              height: 1.5,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 80),
          AppInput(
            key: const Key("input.email"),
            autoFocus: true,
            controller: _usernameInput,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppIcons.user,
            ),
            inputType: TextInputType.emailAddress,
            hint: "Digite seu e-mail",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            msgValidator: "Informe o seu e-mail.",
          ),
          const SizedBox(height: 20),
          AppInput(
            key: const Key("input.password"),
            controller: _passwordInput,
            passwordVisible: false,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppIcons.lock,
            ),
            inputType: TextInputType.visiblePassword,
            hint: "*******",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            msgValidator: "Informe a sua senha.",
          ),
          const SizedBox(height: 25),
          AppValueListenableBuilder(
            valueListenables: [_usernameInput, _passwordInput],
            builder: (_) => AppBtn(
              textColor: AppColors.white,
              text: _controller.isLoading.value ? 'Carregando...' : 'Entrar',
              bgColor: AppColors.brandBlue,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _controller.login(_usernameInput.text, _passwordInput.text);
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () => AppRoutes.recoverPassword.push(),
            child: const Text(
              "Esqueci minha senha",
              style: TextStyle(
                color: AppColors.brandBlue,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.brandBlue,
                height: 1.2,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "ou",
            style: TextStyle(
              color: AppColors.neutral,
              fontFamily: FontFamily.appFont,
              fontWeight: FontWeight.w500,
              height: 1.2,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 50),
          AppBtn(
            textColor: AppColors.white,
            text: 'Cancelar',
            bgColor: AppColors.neutral,
            onPressed: () => AppRoutes.register.push(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
