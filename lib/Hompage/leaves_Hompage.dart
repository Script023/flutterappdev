import 'package:flutter/material.dart';
import 'package:flutterappdev/Hompage/memo_hompage.dart';
import 'package:flutterappdev/Hompage/folio_Homepage.dart';

class LeavesHomePage extends StatelessWidget {
  const LeavesHomePage({super.key});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MemoPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FolioPage()),
      );
    }
    // index == 0 means LEAVES, so we stay on this page
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
              color: Colors.black,
              child: Image.asset('assets/icon.png', width: 40, height: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              'leaves',
              style: TextStyle(
                fontFamily: 'PlayFairDisplay',
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
            // Buttons for Leaves
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                print("Leaves Sign in tapped");
              },
              child: const Text('Sign in'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                print("Leaves Get started tapped");
              },
              child: const Text('Get started'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'LEAVES'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'MEMO'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'FOLIO'),
        ],
        currentIndex: 0, // always highlight LEAVES since this is its page
        selectedItemColor: Colors.brown,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
