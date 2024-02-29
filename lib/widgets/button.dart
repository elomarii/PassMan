import 'package:PassMan/constants/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key, required this.title, required this.onPressed});

  final String title;
  final Future Function() onPressed;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool processing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: AppColors.first,
      alignment: Alignment.center,
      child: InkWell(
        onTap: processing
            ? null
            : () async {
                setState(() {
                  processing = true;
                });
                await widget.onPressed();
                setState(() {
                  processing = false;
                });
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            processing ? "..." : widget.title,
            style: TextStyle(color: AppColors.fifth, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
