import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeu_tien/core/constants/constants.dart';
import 'package:yeu_tien/core/errors/failure.dart';
import 'package:yeu_tien/features/balance/business/entities/balance_entity.dart';
import 'package:yeu_tien/features/balance/presentation/providers/balance_provider.dart';
import 'package:yeu_tien/features/balance/presentation/widgets/custom_container_widget.dart';
import 'package:yeu_tien/features/currency/presentation/providers/selected_currency_provider.dart';
import 'package:yeu_tien/features/sekeleton/provider/selected_page_provider.dart';
import '../../../transaction/business/entities/transaction_entity.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceProvider>(
      builder: (context, balanceProvider, _) {
        Provider.of<BalanceProvider>(context, listen: false).calculateBalance(id: "1");
        BalanceEntity? balance = balanceProvider.balance;
        Failure? failure = balanceProvider.failure;
        String currencySymbol = Provider.of<SelectedCurrencyProvider>(context)
            .selectedCurrencySymbol;

        if (balance != null) {
          return SafeArea(
            child: ListView(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${balance.balance} $currencySymbol",
                            style: const TextStyle(fontSize: 30),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_red_eye_rounded)),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tổng số dư",
                        style: TextStyle(fontSize: 12, color: kNormalText),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Icon(Icons.info_outlined, size: 16, color: kNormalText)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomContainerWidget(
                    widget: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Ví của tôi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                  },
                                  child: Text(
                                    "Xem tất cả",
                                    style: TextStyle(
                                      color: kTextButton,
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 10),
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: kNormalText,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/cash.png",
                                    height: 35,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Tiền mặt",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text("0 $currencySymbol",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ),
                    height: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Báo cáo chi tiêu",
                          style: TextStyle(color: kNormalText)),
                      TextButton(
                          onPressed: () {},
                          child: Text("Xem báo cáo",
                              style: TextStyle(
                                color: kTextButton,
                              )))
                    ],
                  ),
                  CustomContainerWidget(
                    height: 300,
                    widget: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Tuần",
                                    style: TextStyle(color: kPrimaryText),
                                  )),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Tháng",
                                    style: TextStyle(color: kPrimaryText),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "0 $currencySymbol",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Tổng chi tiêu tháng này",
                                style: TextStyle(color: kNormalText),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "0%",
                                style: TextStyle(color: kSpecialText),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giao dịch gần đây",
                        style: TextStyle(color: kNormalText),
                      ),
                      TextButton(
                          onPressed: () {
                            Provider.of<SelectedPageProvider>(context, listen: false).changePage(1);
                          },
                          child: Text(
                            "Xem tất cả",
                            style: TextStyle(color: kTextButton),
                          ))
                    ],
                  ),
                  CustomContainerWidget(
                      widget: Center(
                        child: Text(
                          "Giao dịch đã thêm ở đây",
                          style: TextStyle(color: kNormalText),
                        ),
                      ),
                      height: 200)
                ],
              )
            ]),
          );
        } else if (failure != null) {
          return SafeArea(
            child: Center(
              child: Text(
                failure.errorMessage,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        } else {
          return SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: kTextButton,
              ),
            ),
          );
        }
      },
    );
  }
}
