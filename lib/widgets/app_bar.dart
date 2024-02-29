import 'package:PassMan/constants/colors.dart';
import 'package:flutter/material.dart';

class PassBar extends StatelessWidget implements PreferredSizeWidget {
  const PassBar({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.first,
      elevation: 2,
      title: Row(
        children: [
          Text(
            "PassMan",
            style: TextStyle(
              color: AppColors.fifth,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 57);
}
