import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeu_tien/features/currency/presentation/providers/selected_currency_provider.dart';

import '../../../sekeleton/skeleton.dart';


class SelectCurrencyPage extends StatefulWidget {
  const SelectCurrencyPage({super.key});

  @override
  _SelectCurrencyPageState createState() => _SelectCurrencyPageState();
}

class _SelectCurrencyPageState extends State<SelectCurrencyPage> {
  Currency? selectedCurrency;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboarded = prefs.getBool('onboarded') ?? false;
    if (onboarded) {
      _loadSelectedCurrency();
    }
  }

  _loadSelectedCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currencyCode = prefs.getString('selectedCurrency');
    if (currencyCode != null) {
      setState(() {
        selectedCurrency = CurrencyService().findByCode(currencyCode);
      });
      _navigateToHomeScreen();
    }
  }

  _saveSelectedCurrency(String currencyCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCurrency', currencyCode);
    prefs.setBool('onboarded', true);
    _navigateToHomeScreen();
  }

  _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Skeleton(
          selectedCurrency: selectedCurrency!,
        ),
      ),
    );
  }

  _saveSelectedCurrencySymbol(String currencyCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('symbolCurrency', currencyCode);
    Provider.of<SelectedCurrencyProvider>(context).changeCurrency(currencyCode);
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
                      'Chọn đơn vị tiền tệ bạn sử dụng',
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
                        selectedCurrency != null ? '${selectedCurrency!.name} (${selectedCurrency!.code})' : 'Vui lòng chọn loại tiền tệ',
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
                  "Tiếp tục",
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
