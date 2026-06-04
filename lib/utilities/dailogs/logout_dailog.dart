import 'package:flutter/material.dart';
import 'package:flutterappdev/utilities/dailogs/generic_dailog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Log out",
    content: "Are you sure you want to log out?",
    // returns a map
    optionsBuilder: () => {"Cancel": false, "Log out": true},
  ).then((value) => value ?? false);
}
