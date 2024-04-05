import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class TransactionWidget extends StatefulWidget {
  final String text;
  final double amount;
  final String date;
  const TransactionWidget({super.key, required this.text, required this.amount, required this.date});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        color: kBackgroundContainer,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10),
          child: Row(
            children: [
              Text(
                widget.text,
                style: TextStyle(color: kPrimaryText),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.amount.toString(),
                style: TextStyle(color: kPrimaryText),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  widget.date.toString(),
                  style: TextStyle(color: kPrimaryText),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
