import 'package:flutter/material.dart';

import '../helpers/i18n/i18n.dart';

void showLoadingSpinner(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => SimpleDialog(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10.0),
            Text(
              R.strings.wait,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}

void hideLoadingSpinner(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
