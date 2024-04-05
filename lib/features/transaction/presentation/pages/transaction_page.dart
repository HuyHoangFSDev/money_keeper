import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeu_tien/features/transaction/business/entities/transaction_entity.dart';
import 'package:yeu_tien/features/transaction/presentation/providers/transaction_provider.dart';
import 'package:yeu_tien/features/transaction/presentation/widgets/transaction_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    List<TransactionEntity>? transactions =
        Provider.of<TransactionProvider>(context).transaction;


    if (transactions == null || transactions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Không có giao dịch.'),
        ),
      );
    }

    return  Scaffold(
      body: SafeArea(
        child: ListView(
          children: [Column(
            children: transactions
                .map(
                  (e) => TransactionWidget(text: e.type, amount: e.amount, date: e.addAt,),
            )
                .toList(),
          ),]
        ),
      ),
    );
  }
}
