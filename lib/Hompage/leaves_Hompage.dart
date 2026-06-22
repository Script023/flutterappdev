import 'package:flutter/material.dart';
import 'package:flutterappdev/Hompage/folio_Homepage.dart';
import 'package:flutterappdev/Hompage/memo_hompage.dart';

class LeavesHomePage extends StatefulWidget {
  const LeavesHomePage({super.key});

  @override
  State<LeavesHomePage> createState() => _LeavesHomePageState();
}

class _LeavesHomePageState extends State<LeavesHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(BuildContext context, int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MemoPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FolioPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Image.asset('assets/icon/icon.png', width: 80, height: 80),
            ),
            const SizedBox(height: 20),
            const Text(
              'leaves',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay', // corrected
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'A QUIETER KIND OF NOTES',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'LEAVES'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'MEMO'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'FOLIO'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped(context, index);
        },
      ),
    );
  }
}
