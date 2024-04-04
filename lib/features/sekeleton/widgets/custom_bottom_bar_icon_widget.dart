import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomBarIconWidget extends StatelessWidget {
  const CustomBottomBarIconWidget({
    this.text = "",
    super.key,
    required this.callback,
    required this.iconDataSelected,
    required this.iconDataUnselected,
    required this.isSelected,
  });

  final VoidCallback callback;
  final bool isSelected;
  final IconData iconDataSelected;
  final IconData iconDataUnselected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return (text.isEmpty)
        ? IconButton(
            onPressed: callback,
            icon: Icon(
              isSelected ? iconDataSelected : iconDataUnselected,
              color: const Color.fromRGBO(43, 185, 75, 1),
              size: 60,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: callback,
                icon: Icon(
                  isSelected ? iconDataSelected : iconDataUnselected,
                  color: isSelected
                      ? Colors.white
                      : const Color.fromRGBO(157, 157, 157, 1),
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 8,
                    color: isSelected
                        ? Colors.white
                        : const Color.fromRGBO(157, 157, 157, 1)),
              )
            ],
          );
  }
}
