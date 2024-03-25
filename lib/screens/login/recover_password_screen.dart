import 'package:billx/commons/app_icons.dart';
import 'package:billx/commons/app_value_listenable_builder.dart';
import 'package:billx/commons/formatters/cpf_input_formatter.dart';
import 'package:billx/controllers/recover_password_controller.dart';
import 'package:billx/screens/register/widgets/app_btn_cancel.dart';
import 'package:billx/screens/screen.dart';
import 'package:billx/services/di.dart';
import 'package:billx/widgets/app_btn.dart';
import 'package:billx/widgets/app_input.dart';
import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../commons/app_images.dart';
import '../../commons/font_family.dart';
import '../../utils/sizes.dart';
import '../../controllers/login_controller.dart';
import 'login_btn.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cpfInput = TextEditingController(text: AppRoutes.recoverPassword.arguments);
  final _controller = DI.resolve(RecoverPasswordController());

  @override
  void dispose() {
    _cpfInput.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      isLoading: _controller.isLoading,
      backgroundColor: AppColors.gray,
      formKey: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset(AppImages.logo),
          const SizedBox(height: 50),
          const Text(
            "Esqueceu a senha?",
            style: TextStyle(
              color: AppColors.neutral,
              fontFamily: FontFamily.appFont,
              fontWeight: FontWeight.w600,
              height: 1.5,
              fontSize: 20,
            ),
          ),
          const Text(
            "Informe seu CPF que vamos enviar a recuperação de senha no seu e-mail cadastrado",
            textAlign: TextAlign.center,
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
            key: const Key("input.cpf"),
            autoFocus: true,
            controller: _cpfInput,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppIcons.idGray,
            ),
            fillColor: Colors.white,
            inputType: TextInputType.text,
            inputFormatters: [CpfInputFormatter()],
            hint: "000.000.000-00",
            msgValidator: "Informe o seu CPF.",
          ),
          const SizedBox(height: 20),
          AppValueListenableBuilder(
            valueListenables: [_cpfInput],
            builder: (_) => AppBtn(
              textColor: AppColors.white,
              text: _controller.isLoading.value ? 'Carregando...' : 'Receber no e-mail',
              bgColor: AppColors.brandBlue,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _controller.recoverPassword(_cpfInput.text);
                }
              },
            ),
          ),
          const SizedBox(height: 70),
          const AppBtnCancel(),
          const SizedBox(height: 20),
        ],
      )
    );
  }
}
