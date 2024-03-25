import 'package:flutter/material.dart';

import '../../../commons/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/app_btn.dart';

class AppBtnCancel extends StatelessWidget {
  const AppBtnCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: AppBtn(
        textColor: AppColors.neutral,
        text: 'Cancelar',
        bgColor: AppColors.gray,
        onPressed: () => AppRoutes.login.redirect(),
        border: const BorderSide(
            width: 1.3, // thickness
            color: AppColors.neutral // color
        ),
      ),
    );
  }
}
