import 'package:flutter/material.dart';
import 'package:flutterappdev/Hompage/folio_Homepage.dart';
import 'package:flutterappdev/Hompage/leaves_Hompage.dart';
import 'package:flutterappdev/Hompage/memo_hompage.dart';

class IntroPageView extends StatelessWidget {
  const IntroPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [LeavesHomePage(), MemoPage(), FolioPage()],
      ),
    );
  }
}
