import '../../../extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../commons/app_colors.dart';
import '../../../widgets/listen.dart';


class InputPerfilWidget extends StatelessWidget {
  final _passwordVisible = true.listen;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool enabled;
  final bool autoFocus;
  final String? hint;
  final String? labelText;
  final String? msgValidator;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Color? fillColor;

  InputPerfilWidget({
    this.controller,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.autoFocus = false,
    this.hint,
    this.labelText,
    this.msgValidator,
    this.inputFormatters,
    this.floatingLabelBehavior,
    bool passwordVisible = true,
    this.prefixIcon,
    this.fillColor = AppColors.gray,

    super.key,
  }) {
    _passwordVisible.value = passwordVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Listen(() {
      return Column(
        children: [
          TextFormField(
            controller: controller,
            enabled: enabled,
            autofocus: autoFocus,
            obscureText: !_passwordVisible.value,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            keyboardType: inputType,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: floatingLabelBehavior,
              errorStyle: const TextStyle(fontSize: 0.1),
              filled: true,
              fillColor: fillColor,
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.only(
                top: 20.0,
                bottom: 15.0,
                left: 25.0,
                right: 20.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.inputHint,
              ),
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
              suffixIcon: inputType == TextInputType.visiblePassword
                  ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    _passwordVisible.value = !_passwordVisible.value;
                  },
                  icon: Icon(
                    !_passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.neutral,
                  ),
                ),
              )
                  : null,
            ),

            inputFormatters: inputFormatters,
          ),

        ],
      );
    });
  }
}
