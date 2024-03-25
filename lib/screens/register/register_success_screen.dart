 import 'package:flutter/material.dart';
import '../../commons/app_images.dart';

import '../../commons/app_colors.dart';
import '../../commons/font_family.dart';
import '../../controllers/register_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../widgets/app_btn.dart';
import '../screen.dart';

//tela sem alguma interação só o btn de voltar para o inicio, tela com o objetivo de demonstrar o sucesso no registro

class RegisterSuccessScreen extends StatefulWidget {
  const RegisterSuccessScreen({super.key});

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
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
              const SizedBox(height: 30),
              Image.asset(AppImages.logo),
              const SizedBox(height: 180),
              const Text(
                "Tudo certo!",
                style: TextStyle(
                  color: AppColors.brandBlue,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Sua conta foi criada!",
                style: TextStyle(
                  color: AppColors.brandBlue,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.check_circle,
                color: AppColors.brandBlue,
                size: 100,
              ),

              const SizedBox(height: 250),
              AppBtn(
                  textColor: AppColors.neutral,
                  text: 'Voltar para o início',
                  bgColor: AppColors.gray,
                    border: const BorderSide(
                        width: 1.3,
                        color: AppColors.neutral

                    ),
                  onPressed: () => {
                    AppRoutes.login.push()
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
