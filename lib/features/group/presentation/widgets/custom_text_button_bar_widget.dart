import 'package:flutter/material.dart';
import 'package:yeu_tien/core/constants/constants.dart';

class CustomTextButtonBarWidget extends StatelessWidget {
  const CustomTextButtonBarWidget({
    this.text = "",
    super.key,
    required this.callback,
    required this.isSelected,
  });

  final VoidCallback callback;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(fontSize: 14, color: kPrimaryText),
        ));
  }
}
