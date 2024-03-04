import 'package:PassMan/constants/colors.dart';
import 'package:flutter/material.dart';

class PassBar extends StatelessWidget implements PreferredSizeWidget {
  const PassBar({super.key, this.actions, this.title});

  final List<Widget>? actions;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.first,
      elevation: 2,
      title: RichText(
        text: TextSpan(
          text: "PassMan",
          style: TextStyle(
            color: AppColors.fifth,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Kode-mono",
          ),
          children: <TextSpan>[
            TextSpan(
              text: title == null ? "" : " // ${title!}",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 57);
}
