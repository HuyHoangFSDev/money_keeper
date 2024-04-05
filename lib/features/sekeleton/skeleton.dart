import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeu_tien/features/sekeleton/pages/budget.dart';
import 'package:yeu_tien/features/sekeleton/pages/profile.dart';
import 'package:yeu_tien/features/sekeleton/provider/selected_page_provider.dart';
import 'package:yeu_tien/features/sekeleton/widgets/custom_bottom_bar_widget.dart';

import '../balance/presentation/pages/balance_page.dart';
import '../transaction/presentation/pages/add_transaction_page.dart';
import '../transaction/presentation/pages/transaction_page.dart';

List<Widget> pages =  [
  const BalancePage(),
  const TransactionPage(),
  const AddTransactionPage(),
  const BudgetPage(),
  const ProfilePage()
];

class Skeleton extends StatefulWidget {
  final Currency selectedCurrency;
  const Skeleton({super.key, required this.selectedCurrency});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: pages[selectedPage],
    );
  }
}
