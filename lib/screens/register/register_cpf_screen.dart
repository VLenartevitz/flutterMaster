import 'package:flutter/material.dart';

import '../../commons/app_icons.dart';
import '../../commons/app_images.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../commons/font_family.dart';
import '../../commons/formatters/cpf_input_formatter.dart';
import '../../commons/app_colors.dart';
import '../../controllers/register_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';
import 'widgets/app_btn_cancel.dart';
import 'widgets/modal_terms.dart';
import '../../widgets/app_btn.dart';
import 'widgets/steps_widget.dart';

class RegisterCpfScreen extends StatefulWidget {
  const RegisterCpfScreen({super.key});

  @override
  State<RegisterCpfScreen> createState() => _RegisterCpfScreenState();
}

class _RegisterCpfScreenState extends State<RegisterCpfScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cpfInput = TextEditingController();
  final _controller = DI.resolve(RegisterController());

  @override
  void initState() {
    super.initState();
    _controller.loadTermsOfUse();
  }

  @override
  void dispose() {
    _cpfInput.dispose();
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
                "Seja bem vinda(o)!",
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Precisamos do seu CPF \npara começar",
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
                controller: _cpfInput,
                fillColor: AppColors.light,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AppIcons.id,
                ),
                autoFocus: true,
                inputType: TextInputType.number,
                inputFormatters: [CpfInputFormatter()],
                hint: "000.000.000-00",
                msgValidator: "Informe o seu cpf.",
              ),
              const SizedBox(height: 20),
              AppValueListenableBuilder(
                valueListenables: [_cpfInput],
                builder: (_) => AppBtn(
                  textColor: AppColors.white,
                  text: 'Continuar',
                  bgColor: AppColors.brandBlue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.form.value['cpf'] = _cpfInput.text;

                      AppRoutes.registerDateBirth.push();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Text(
                    "Ao prosseguir com seu cadastro você \ndeclara que leu e concordou com os",
                    style: TextStyle(
                      color: AppColors.neutral,
                      fontFamily: FontFamily.appFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () => showTerms(
                          context,
                          _controller.terms.content,
                        ),
                        child: const Text(
                          "termos de uso",
                          style: TextStyle(
                            color: AppColors.neutral,
                            fontFamily: FontFamily.appFont,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.neutral,
                            height: 1.2,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Text(
                        " do aplicativo.",
                        style: TextStyle(
                          color: AppColors.neutral,
                          fontFamily: FontFamily.appFont,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const AppBtnCancel(),
        ],
      ),
    );
  }
}
