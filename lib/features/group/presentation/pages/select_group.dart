import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeu_tien/core/constants/constants.dart';
import 'package:yeu_tien/features/group/presentation/providers/select_group_provider.dart';
import 'package:yeu_tien/features/group/presentation/widgets/custom_text_button_bar_widget.dart';
import 'package:yeu_tien/features/group/presentation/widgets/income_widget.dart';
import 'package:yeu_tien/features/group/presentation/widgets/spending_widget.dart';

List<Widget> groups = const [
  SpendingWidget(),
  IncomeWidget(),
];

class SelectGroupPage extends StatefulWidget {
  const SelectGroupPage({super.key});

  @override
  State<SelectGroupPage> createState() => _SelectGroupPageState();
}

class _SelectGroupPageState extends State<SelectGroupPage> {
  @override
  Widget build(BuildContext context) {
    int selectGroup = Provider.of<SelectedGroupProvider>(context).selectedGroup;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Chọn nhóm"),
            Row(
              children: [
                Icon(Icons.menu_outlined),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.search)
              ],
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: kNormalText),
                    top: BorderSide(width: 1, color: kNormalText))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextButtonBarWidget(
                      callback: () {
                        Provider.of<SelectedGroupProvider>(context,
                                listen: false)
                            .changeGroup(0);
                      },
                      isSelected: selectGroup == 0,
                      text: 'KHOẢN CHI',
                    ),
                    CustomTextButtonBarWidget(
                      callback: () {
                        Provider.of<SelectedGroupProvider>(context,
                                listen: false)
                            .changeGroup(1);
                      },
                      isSelected: selectGroup == 1,
                      text: 'KHOẢN THU',
                    )
                  ],
                ),
                Align(
                  alignment: selectGroup == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: LayoutBuilder(
                    builder: (context, box) => SizedBox(
                      width: box.maxWidth / 2,
                      child: const Divider(
                        height: 0,
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          groups[selectGroup]
        ],
      ),
    );
  }
}
