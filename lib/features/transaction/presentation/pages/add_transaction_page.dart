import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeu_tien/core/constants/constants.dart';
import 'package:yeu_tien/features/balance/presentation/providers/balance_provider.dart';
import 'package:yeu_tien/features/sekeleton/provider/selected_page_provider.dart';
import 'package:yeu_tien/features/transaction/presentation/providers/transaction_provider.dart';

import '../../../group/presentation/providers/select_group_provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  double amount = 0;

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
    Provider.of<TransactionProvider>(context, listen: false);
    int selectGroup = Provider.of<SelectedGroupProvider>(context).selectedGroup;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundContainer,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Provider.of<SelectedPageProvider>(context, listen: false)
                      .changePage(0);
                },
                icon: const Icon(Icons.close)),
            const SizedBox(
              width: 20,
            ),
            Text(
              "Thêm giao dịch",
              style: TextStyle(color: kPrimaryText),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: kBackgroundContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.money),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                amount = double.parse(text);
                              });
                            },
                            style: TextStyle(color: kTextButton),
                            decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(color: kTextButton),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kTextButton,
                                        style: BorderStyle.solid))),
                            cursorColor: kTextButton,
                            keyboardType:
                            const TextInputType.numberWithOptions(),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/selectgroup');
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.select_all_sharp),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Chọn nhóm",
                            style: TextStyle(color: kNormalText, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.notes),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Thêm ghi chú",
                          style: TextStyle(color: kNormalText, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Hôm nay",
                          style: TextStyle(color: kPrimaryText, fontSize: 16),
                        )
                      ],
                    ),
                    Row(children: [
                      const Icon(Icons.wallet_outlined),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Tiền mặt",
                        style: TextStyle(color: kPrimaryText, fontSize: 16),
                      )
                    ])
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                transactionProvider.postTransaction(id: Random().nextInt(100).toString(),
                    balanceID: "1",
                    group: "group",
                    amount: amount,
                    note: "note",
                    type: (selectGroup == 0)? "spending" : "income",
                    addAt: DateTime.now().toString());
                transactionProvider.eitherFailureOrTransaction();
                Provider.of<BalanceProvider>(context, listen: false).calculateBalance(id: "1");
                Provider.of<BalanceProvider>(context, listen: false).eitherFailureOrBalance(value: "1");
                Provider.of<SelectedPageProvider>(context, listen: false).changePage(0);
              },
              style: TextButton.styleFrom(
                  backgroundColor: kBackgroundContainer,
                  fixedSize: const Size(300, 25)),
              child: Text(
                "Lưu",
                style: TextStyle(color: kNormalText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
