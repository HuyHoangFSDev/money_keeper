import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/selected_page_provider.dart';
import 'custom_bottom_bar_icon_widget.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;

    return SafeArea(
      child: BottomAppBar(
        padding: EdgeInsets.zero,
        height: 75,
        color: const Color.fromRGBO(49, 49, 49, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBottomBarIconWidget(
              iconDataSelected: Icons.home_filled,
              iconDataUnselected: Icons.home_outlined,
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(0);
              },
              isSelected: selectedPage == 0,
              text: 'Tổng quan',
            ),
            CustomBottomBarIconWidget(
              iconDataSelected: Icons.wallet,
              iconDataUnselected: Icons.wallet_rounded,
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(1);
              },
              isSelected: selectedPage == 1,
              text: 'Sổ giao dịch',
            ),
            CustomBottomBarIconWidget(
              iconDataSelected: Icons.add_circle,
              iconDataUnselected: Icons.add_circle_outline_rounded,
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(2);
              },
              isSelected: selectedPage == 2,
            ),
            CustomBottomBarIconWidget(
              iconDataSelected: Icons.monetization_on,
              iconDataUnselected: Icons.monetization_on_outlined,
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(3);
              },
              isSelected: selectedPage == 3,
              text: 'Ngân sách',
            ),
            CustomBottomBarIconWidget(
              iconDataSelected: Icons.account_circle_rounded,
              iconDataUnselected: Icons.account_circle_outlined,
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(4);
              },
              isSelected: selectedPage == 4,
              text: 'Tài khoản',
            ),
          ],
        ),
      ),
    );
  }
}
