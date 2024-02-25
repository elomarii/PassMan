import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/views/home/home_controller.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:cryptography/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.second,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.first,
        elevation: 2,
        title: Text(
          "PassMan",
          style: TextStyle(
            color: AppColors.fifth,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          PasswordCard(title: "Facebook", value: "abcd123564"),
          SizedBox(height: 10),
          PasswordCard(title: "Twitter", value: "xyz@154hihi"),
        ],
      ),
    );
  }
}

class PasswordCard extends StatefulWidget {
  const PasswordCard({super.key, required this.title, required this.value});

  final String title;
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
              onTap: () {
                Clipboard.setData(ClipboardData(text: widget.value));
                Get.showSnackbar(GetSnackBar(
                  message: "${widget.title}'s password was copied!",
                  duration: const Duration(seconds: 2),
                ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
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
              isShown ? Icons.password : Icons.abc,
              color: AppColors.fourth,
            ),
          )
        ],
      ),
    );
  }
}
