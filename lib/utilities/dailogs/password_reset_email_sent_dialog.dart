import 'package:flutter/widgets.dart';
import 'package:flutterappdev/utilities/dailogs/generic_dailog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    content:
        'we have now sent you a password reset link, check your email for more info',
    context: context,
    title: 'Password Reset',
    optionsBuilder: () => {'OK': null},
  );
}
