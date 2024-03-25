import 'package:flutter/material.dart';

import '../../commons/app_icons.dart';
import '../../routes/app_routes.dart';
import '../../commons/app_images.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../commons/font_family.dart';
import '../../commons/app_colors.dart';
import '../../commons/formatters/date_input_formatter.dart';
import '../../controllers/register_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';
import 'widgets/app_btn_cancel.dart';
import 'widgets/modal_terms.dart';
import '../../widgets/app_btn.dart';
import 'widgets/steps_widget.dart';

class RegisterDateBirthScreen extends StatefulWidget {
  const RegisterDateBirthScreen({super.key});

  @override
  State<RegisterDateBirthScreen> createState() =>
      _RegisterDateBirthScreenState();
}

class _RegisterDateBirthScreenState extends State<RegisterDateBirthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateInput = TextEditingController();
  final _controller = DI.resolve(RegisterController());

  @override
  void initState() {
    super.initState();
    _controller.loadTermsOfUse();
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
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              const StepsWidget(),
              const SizedBox(height: 30),
              Image.asset(AppImages.logo),
              const SizedBox(height: 50),
              const Text(
                "Ótimo!",
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Agora, qual sua data \nde nascimento?",
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
                controller: _dateInput,
                fillColor: AppColors.light,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AppIcons.calendar,
                ),
                autoFocus: true,
                inputType: TextInputType.number,
                inputFormatters: [DateInputFormatter()],
                hint: "DD/MM/YYYY",
                msgValidator: "Informe a sua data de nascimento.",
              ),
              const SizedBox(height: 20),
              AppValueListenableBuilder(
                valueListenables: [_dateInput],
                builder: (_) => AppBtn(
                  textColor: AppColors.white,
                  text: 'Continuar',
                  bgColor: AppColors.brandBlue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.form.value['birth_date'] = _dateInput.text;

                      AppRoutes.registerPersonalIdentification.push();
                      _controller.searchCpf();

                      AppRoutes.registerConfirmationName.push();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Precisamos desta informação para sua \nprópria segurança.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const AppBtnCancel(),
        ],
      ),
    );
  }
}
