import 'package:flutter/material.dart';
import 'package:yeu_tien/features/group/data/datasources/datasources.dart';

import 'group_widget.dart';

class SpendingWidget extends StatefulWidget {
  const SpendingWidget({super.key});

  @override
  State<SpendingWidget> createState() => _SpendingWidgetState();
}

class _SpendingWidgetState extends State<SpendingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: spendingGroups.map((e) => GroupWidget(image: e.image, text: e.text)).toList(),
    );
  }
}
