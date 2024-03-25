import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../commons/font_family.dart';
import '../../commons/formatters/phone_input_formatter.dart';
import '../../controllers/register_controller.dart';
import '../../services/di.dart';
import '../../widgets/app_back_btn.dart';
import '../../widgets/app_btn.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';

class RegisterPhoneScreen extends StatefulWidget {
  const RegisterPhoneScreen({super.key});

  @override
  State<RegisterPhoneScreen> createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DI.resolve(RegisterController());

  final _phoneInput = TextEditingController();

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
                "Para darmos sequência nos informe seu número de \ncelular",
                style: TextStyle(
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ele será usado para avisar sobre transações \ne novidades da conta.",
                style: TextStyle(
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: _phoneInput,
                autoFocus: true,
                inputType: TextInputType.number,
                inputFormatters: [PhoneInputFormatter()],
                hint: "(00) 00000-0000",
                msgValidator: "Informe o número do celular.",
              ),
            ],
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _phoneInput,
            builder: (context, value, child) {
              return AppBtn(
                textColor: AppColors.white,
                text: 'Continuar',
                bgColor: AppColors.primary,
                onPressed: _phoneInput.text.isEmpty || _phoneInput.text.length < 15 ? null : () {
                  if (_formKey.currentState!.validate()) {
                    _controller.sendValidationCodeToPhone(
                      _phoneInput.text,
                    );
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
