import 'package:flutter/material.dart';

import '../../commons/app_icons.dart';
import '../../commons/app_images.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../commons/font_family.dart';
import '../../commons/formatters/phone_input_formatter.dart';
import '../../commons/app_colors.dart';
import '../../controllers/register_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';
import 'widgets/app_btn_cancel.dart';
import '../../widgets/app_btn.dart';
import 'widgets/steps_widget.dart';

class RegisterPhoneNumberScreen extends StatefulWidget {
  const RegisterPhoneNumberScreen({super.key});

  @override
  State<RegisterPhoneNumberScreen> createState() => _RegisterPhoneNumberScreenState();
}

class _RegisterPhoneNumberScreenState extends State<RegisterPhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberInput = TextEditingController();
  final _controller = DI.resolve(RegisterController());

  @override
  void dispose() {
    _phoneNumberInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      formKey: _formKey,
      isLoading: _controller.isLoading,
      backgroundColor: AppColors.gray,
      height: MediaQuery.of(context).size.height / 1.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              const StepsWidget(),
              const SizedBox(height: 30),
              Image.asset(AppImages.logo),
              const SizedBox(height: 50),
              const Text(
                "Falta pouco...",
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Qual o seu celular?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 40),
              AppInput(
                controller: _phoneNumberInput,
                fillColor: AppColors.light,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AppIcons.id,
                ),
                autoFocus: true,
                inputType: TextInputType.number,
                inputFormatters: [PhoneInputFormatter()],
                hint: "(00) 00000-0000",
                msgValidator: "Informe o número de celular.",
              ),
              const SizedBox(height: 20),
              AppValueListenableBuilder(
                valueListenables: [_phoneNumberInput],
                builder: (_) => AppBtn(
                  textColor: AppColors.white,
                  text: 'Continuar',
                  bgColor: AppColors.brandBlue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.form.value['phone_number'] = _phoneNumberInput.text;

                      AppRoutes.registerEmail.push();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),

          const AppBtnCancel(),
        ],
      ),
    );
  }
}
