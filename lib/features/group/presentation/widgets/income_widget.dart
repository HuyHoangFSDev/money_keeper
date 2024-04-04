import 'package:flutter/material.dart';
import 'package:yeu_tien/features/group/data/datasources/datasources.dart';
import 'package:yeu_tien/features/group/presentation/widgets/group_widget.dart';




class IncomeWidget extends StatefulWidget {
  const IncomeWidget({super.key});

  @override
  State<IncomeWidget> createState() => _IncomeWidgetState();
}

class _IncomeWidgetState extends State<IncomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: incomeGroups.map((e) => GroupWidget(image: e.image, text: e.text)).toList(),
    );
  }
}
