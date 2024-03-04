import 'package:PassMan/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.onSubmit,
    this.label = "",
    this.obscured = false,
    this.fillColor,
    this.controller,
  });

  final void Function(String)? onSubmit;
  final String label;
  final bool obscured;
  final Color? fillColor;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) return "input something !";
        return null;
      },
      controller: controller,
      onFieldSubmitted: onSubmit,
      textInputAction: TextInputAction.next,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      obscureText: obscured,
      style: TextStyle(color: AppColors.white),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        label: Center(child: Text(label)),
        labelStyle: TextStyle(color: AppColors.fourth),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelStyle: TextStyle(color: AppColors.fourth),
        filled: true,
        fillColor: fillColor ?? AppColors.second,
        border: InputBorder.none,
        errorStyle: TextStyle(color: AppColors.fourth),
      ),
    );
  }
}
