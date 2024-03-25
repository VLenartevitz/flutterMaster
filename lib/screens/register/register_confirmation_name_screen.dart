import 'package:billx/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../commons/app_images.dart';
import '../../commons/font_family.dart';
import '../../commons/app_colors.dart';
import '../../controllers/register_controller.dart';
import '../../services/di.dart';
import '../screen.dart';
import 'widgets/app_btn_cancel.dart';
import '../../widgets/app_btn.dart';
import 'widgets/steps_widget.dart';

class RegisterConfirmationNameScreen extends StatefulWidget {
  const RegisterConfirmationNameScreen({super.key});

  @override
  State<RegisterConfirmationNameScreen> createState() => _RegisterConfirmationNameScreenState();
}

class _RegisterConfirmationNameScreenState extends State<RegisterConfirmationNameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DI.resolve(RegisterController());

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
                "Este é seu nome?",
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              Text(
                "${_controller.form.value['name']}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 80),
              AppBtn(
                  textColor: AppColors.white,
                  text: 'Sim, vamos continuar!',
                  bgColor: AppColors.brandBlue,
                  onPressed: () => {
                    AppRoutes.registerPersonalIdentification.push()
                  }),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    _controller.form.value['name'] = '';
                  },
                  child: const Text(
                    'Este não é meu nome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.neutral,
                      fontFamily: FontFamily.appFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      decoration: TextDecoration.underline
                    ),
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
