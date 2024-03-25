import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/listen.dart';
import '../widgets/lock_screen.dart';

class Screen extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final PreferredSizeWidget? appBar;
  final RxBool isLoading;
  final Widget child;
  final double? height;
  final Color? backgroundColor;

  const Screen({
    required this.child,
    required this.isLoading,
    this.formKey,
    this.appBar,
    this.height,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: appBar,
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey ?? GlobalKey<FormState>(),
                child: Container(
                  height: height,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          Listen(() => isLoading.value ? const LockScreen(opacity: 0.4) : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
