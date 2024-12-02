import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, this.onPress, required this.text, this.colour});

  final Function? onPress;
  final String text;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonBorderRadius),
              side: BorderSide(
                  color: colour ?? Colors.amber,
                  width: kButtonBorderWidth,
                  style: BorderStyle.solid),
            ),
          ),
        ),
        onPressed: onPress != null
            ? () {
          if (kDebugMode) {
            print('BUTTON PRESSED');
          }
          onPress!();
        }
            : () {
          if (kDebugMode) {
            print('Empty onPressed');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: kAnswerButtonText.copyWith(color: colour),
          ),
        ),
      ),
    );
  }
}