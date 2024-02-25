import 'package:PassMan/constants/colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.horizontalPadding = 15,
    this.bgColor,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final double horizontalPadding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: bgColor ?? AppColors.first,
        appBar: appBar,
        extendBody: true,
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                right: horizontalPadding,
                left: horizontalPadding,
                top: appBar == null ? 25 : 0,
              ),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
