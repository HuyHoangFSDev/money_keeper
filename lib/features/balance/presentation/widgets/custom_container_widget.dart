import 'package:flutter/material.dart';

class CustomContainerWidget extends StatefulWidget {
  final Widget widget;
  final double height;
  const CustomContainerWidget({super.key, required this.widget, required this.height});

  @override
  State<CustomContainerWidget> createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromRGBO(29, 29, 29, 1)),
      child: widget.widget,
    );
  }
}
