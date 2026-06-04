// the values of your generic dialogue must be of the same data type we are going
// to allocate T to these values when we call the generic dialogue
import 'package:flutter/material.dart';

//showDeleteDialog;
// showErrorDialog;
typedef DailogOptionBuilder<T> = Map<String, T?> Function();
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DailogOptionBuilder<T> optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final T? value = options[optionTitle]; // nullable
          if (value == null) {
            // handle the null case explicitly
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop(null); // or do nothing
              },
              child: Text(optionTitle),
            );
          } else {
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop(value);
              },
              child: Text(optionTitle),
            );
          }
        }).toList(),
      );
    },
  );
}
