import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:cryptography/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PasswordCard extends StatefulWidget {
  const PasswordCard(
      {super.key,
      required this.platform,
      required this.value,
      required this.id});

  final int id;
  final String platform;
  final String value;

  @override
  State<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  String scrambled = randomBytesAsHexString(10);
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.first),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.toNamed(
                AppRoutes.password,
                arguments: [widget.id, widget.platform, widget.value],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.platform,
                    style: TextStyle(
                        color: AppColors.fifth,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isShown ? widget.value : scrambled,
                    style: TextStyle(color: AppColors.white),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              isShown = !isShown;
            }),
            child: Icon(
              isShown ? Icons.lock_open : Icons.lock,
              color: AppColors.fourth,
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.value));
              Get.showSnackbar(GetSnackBar(
                message: "${widget.platform}'s password was copied!",
                duration: const Duration(seconds: 2),
              ));
            },
            child: Icon(
              Icons.copy,
              color: AppColors.fourth,
            ),
          ),
        ],
      ),
    );
  }
}
