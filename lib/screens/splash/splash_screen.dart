import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../services/di.dart';
import 'widget_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double width = 400;
  double height = 230;
  double widthName = 0;
  bool isLoading = true;
  String name = "CARTEIRA DIGITAL DE PAGAMENTO DE CONTAS";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 0), () {
        setState(() {
          width = 250;
          height = 130;
        });
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          widthName = 400;
          isLoading = true;
        });
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          widthName = 500;
          isLoading = true;
        });
      });

      Future.delayed(const Duration(seconds: 1, milliseconds: 500), () async {
        DI.resolve(AuthController(), permanent: true).reAuthenticate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetSplash(
      height: height,
      width: width,
      isLoading: isLoading,
      widthName: widthName,
      name: name,
    );
  }
}

