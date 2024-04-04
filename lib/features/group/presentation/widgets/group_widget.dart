import 'package:flutter/material.dart';
import 'package:yeu_tien/core/constants/constants.dart';

class GroupWidget extends StatefulWidget {
  final String text;
  final String image;

  const GroupWidget({super.key, required this.image, required this.text});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        color: kBackgroundContainer,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.image),
                radius: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.text,
                style: TextStyle(color: kPrimaryText),
              )
            ],
          ),
        ),
      ),
    );
  }
}
