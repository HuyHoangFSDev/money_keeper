import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../currency/presentation/providers/selected_currency_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Currency? selectedCurrency;

  @override
  void initState() {
    _loadSelectedCurrency();
    super.initState();
  }

  Future<void> _loadSelectedCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currencyCode = prefs.getString('selectedCurrency');
    if (currencyCode != null) {
      setState(() {
        selectedCurrency = CurrencyService().findByCode(currencyCode);
      });
    }
  }

  Future<void> _saveSelectedCurrency(String currencyCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCurrency', currencyCode);
    prefs.setBool('onboarded', true);
  }

  Future<void> _saveSelectedCurrencySymbol(String currencyCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('symbolCurrency', currencyCode);
    Provider.of<SelectedCurrencyProvider>(context, listen: false)
        .changeCurrency(currencyCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const Text(
                      'Chọn đơn vị tiền tệ bạn muốn thay đổi',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const Text(
                      'Bạn có thể thay đổi sang đơn vị tiền khác bất cứ lúc nào',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.white38),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(370),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(color: Colors.white38, width: 2),
                        backgroundColor: const Color(0xFF696868),
                      ),
                      onPressed: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showSearchField: true,
                          showCurrencyCode: true,
                          favorite: ['vn'],
                          onSelect: (Currency currency) {
                            setState(() {
                              selectedCurrency = currency;
                            });
                          },
                        );
                      },
                      child: Text(
                        selectedCurrency != null
                            ? '${selectedCurrency!.name} (${selectedCurrency!.code})'
                            : 'Vui lòng chọn loại tiền tệ',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(370),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (selectedCurrency != null) {
                    _saveSelectedCurrency(selectedCurrency!.code);
                    _saveSelectedCurrencySymbol(selectedCurrency!.symbol);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            content: Text("Đổi thành công!!"),
                          );
                        });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Lỗi'),
                          content: const Text('Vui lòng chọn đơn vị tiền tệ'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Lưu",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
