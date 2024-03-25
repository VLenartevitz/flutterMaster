import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../commons/app_colors.dart';

class InputCodeWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool autoFocus;
  final String? hint;
  final ValueChanged<String>? onChanged;

  const InputCodeWidget({
    this.focusNode,
    this.controller,
    this.inputType,
    this.autoFocus = false,
    this.hint = '0',
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      width: 76,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onChanged: onChanged,
        focusNode: focusNode,
        maxLength: 1,
        autofocus: autoFocus,
        controller: controller,
        keyboardType: inputType ?? TextInputType.number,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 32,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inputFormatters:  <TextInputFormatter> [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
