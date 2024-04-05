import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeu_tien/core/constants/constants.dart';
import 'package:yeu_tien/features/balance/presentation/providers/balance_provider.dart';
import 'package:yeu_tien/features/balance/presentation/providers/selected_balance_provider.dart';
import 'package:yeu_tien/features/currency/presentation/providers/selected_currency_provider.dart';
import 'package:yeu_tien/features/group/presentation/pages/select_group.dart';
import 'package:yeu_tien/features/group/presentation/providers/select_group_provider.dart';
import 'package:yeu_tien/features/sekeleton/provider/selected_page_provider.dart';
import 'package:yeu_tien/features/sekeleton/skeleton.dart';
import 'package:yeu_tien/features/transaction/business/entities/transaction_entity.dart';
import 'package:yeu_tien/features/transaction/data/models/transaction_model.dart';
import 'package:yeu_tien/features/transaction/presentation/providers/transaction_provider.dart';

import 'features/currency/presentation/pages/select_currency.dart';

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//
//                -ooOoo-                       NAM MÔ A DI ĐÀ PHẬT !
//               o8888888o
//               88" . "88      Thí chủ con tên là Nguyễn Thế Huy Hoàng, dương lịch hai sáu tháng mười một năm 2002
//               (| -_- |)      Ngụ tại Xóm 3 Đồng Nhân, Hà Nội, Việt Nam
//                O\ = /O
//             ___/`---'\___            Con lạy chín phương trời, con lạy mười phương đất
//            .' \\| |// `.             Chư Phật mười phương, mười phương chư Phật
//          / \\||| : |||// \           Con ơn nhờ Trời đất chổ che, Thánh Thần cứu độ
//         / _||||| -:- |||||-\         Xin nhất tâm kính lễ Hoàng thiên Hậu thổ, Tiên Phật Thánh Thần
//           | | \\\ - /// | |          Giúp đỡ con code sạch ít bug
//         | \_| ''\---/'' | |          Đồng nghiệp vui vẻ, sếp quý tăng lương
//         \ .-\__ '-' ___/-. /         Sức khoẻ dồi dào, tiền vào như nước
//       ___. .' /--.--\ . . __
//   ."" '< `.___\_<|>_/___.' >'"".     NAM MÔ VIÊN THÔNG GIÁO CHỦ ĐẠI TỪ ĐẠI BI TẦM THANH CỨU KHỔ CỨU NẠN
//    | | : - \.;`\ _ /`;.`/ - ` : | |  QUẢNG ĐẠI LINH CẢM QUÁN THẾ ÂM BỒ TÁT
//     \ \ -. \_ __\ /__ _/ .- / /
//======`-.____-.___\_____/___.-____.-'======
//                `=---='
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

void main() {
  runApp(const MoneySaverApp());
}

class MoneySaverApp extends StatefulWidget {
  const MoneySaverApp({super.key});

  @override
  State<MoneySaverApp> createState() => _MoneySaverAppState();
}

class _MoneySaverAppState extends State<MoneySaverApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedPageProvider()),
        ChangeNotifierProvider(create: (context) => SelectedCurrencyProvider()),
        ChangeNotifierProvider(create: (context) => BalanceProvider()),
        ChangeNotifierProvider(create: (context) => SelectedBalanceProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => SelectedGroupProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme(
                background: Colors.black,
                brightness: Brightness.dark,
                primary: Colors.green,
                onPrimary: Colors.white,
                secondary: Colors.white,
                onSecondary: Colors.white,
                error: Colors.redAccent,
                onError: Colors.red,
                onBackground: Colors.green,
                surface: Colors.black,
                onSurface: Colors.white),
            useMaterial3: true,
            primarySwatch: Colors.teal,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            iconTheme: const IconThemeData(color: Colors.white)),
        home: const Home(),
        routes: {'/selectgroup': (context) => const SelectGroupPage()},
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    setupApp();
    super.initState();
  }

  void setupApp() {
    SelectedBalanceProvider selectedBalanceProvider =
        Provider.of<SelectedBalanceProvider>(context, listen: false);
    Provider.of<BalanceProvider>(context, listen: false).eitherFailureOrBalance(
        value: (selectedBalanceProvider.number + 1).toString());
    Provider.of<TransactionProvider>(context, listen: false)
        .eitherFailureOrTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return const SelectCurrencyPage();
  }
}
