import 'package:flutter/material.dart';

class MemoPage extends StatelessWidget {
  const MemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MEMO',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 32,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: Image.asset('assets/icon.png', width: 40, height: 40),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 18,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: 'Your thoughts are '),
                  TextSpan(
                    text: 'finally ',
                    style: TextStyle(color: Colors.brown),
                  ),
                  TextSpan(text: 'at rest.'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'A minimal space for ideas that deserve to breathe. No clutter. No noise.',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 12,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Buttons for Memo
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                print("Memo Sign in tapped");
              },
              child: const Text('Sign in'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                print('Memo Get Started tyapped');
              },
              child: const Text('Get started'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Free forever · No account needed to start',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
