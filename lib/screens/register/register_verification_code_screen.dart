 import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../commons/font_family.dart';
import '../../controllers/register_controller.dart';
import '../../services/di.dart';
import '../../widgets/app_back_btn.dart';
import '../../widgets/app_btn.dart';
import '../../widgets/listen.dart';
import '../screen.dart';
import 'widgets/input_code_widget.dart';

class RegisterVerificationCodeScreen extends StatefulWidget {
  const RegisterVerificationCodeScreen({super.key});

  @override
  State<RegisterVerificationCodeScreen> createState() => _RegisterVerificationCodeScreenState();
}

class _RegisterVerificationCodeScreenState extends State<RegisterVerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DI.resolve(RegisterController());

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  final _codeInput1 = TextEditingController();
  final _codeInput2 = TextEditingController();
  final _codeInput3 = TextEditingController();
  final _codeInput4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.startTimer();
  }

  @override
  void dispose() {
    _codeInput1.dispose();
    _codeInput2.dispose();
    _codeInput3.dispose();
    _codeInput4.dispose();

    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

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
                "Insira o código recebido via \nSMS",
                style: TextStyle(
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputCodeWidget(
                    focusNode: _focusNode1,
                    controller: _codeInput1,
                    autoFocus: true,
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        _focusNode2.requestFocus();
                      }
                    },
                  ),
                  InputCodeWidget(
                    focusNode: _focusNode2,
                    controller: _codeInput2,
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        _focusNode3.requestFocus();
                      }
                    },
                  ),
                  InputCodeWidget(
                    focusNode: _focusNode3,
                    controller: _codeInput3,
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        _focusNode4.requestFocus();
                      }
                    },
                  ),
                  InputCodeWidget(
                    focusNode: _focusNode4,
                    controller: _codeInput4,
                    onChanged: (value) {
                      if (value.isNotEmpty && _formKey.currentState!.validate()) {
                        _controller.validateVerificationCode(_verificationCode());
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Listen(() {
                  return Text(
                    "Solicitar novo código em ${_controller.counter.value}s",
                    style: const TextStyle(
                      fontFamily: FontFamily.appFont,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      fontSize: 16,
                    ),
                  );
                }),
              ),
            ],
          ),
          Listen(() {
            return AppBtn(
              textColor: AppColors.white,
              text: 'Solicitar novo código',
              bgColor: AppColors.primary,
              onPressed: _controller.counter.value == 0 ? () => _controller.reSendValidationCodeToPhone() : null,
            );
          }),
        ],
      ),
    );
  }

  String _verificationCode() {
    return _codeInput1.text + _codeInput2.text + _codeInput3.text + _codeInput4.text;
  }
}
