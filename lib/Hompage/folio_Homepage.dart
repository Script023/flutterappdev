import 'package:flutter/material.dart';

class FolioPage extends StatelessWidget {
  const FolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar with logo and version info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icon.png', width: 28, height: 28),
                    SizedBox(width: 8),
                    Text(
                      'folio',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Capture everything.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Forget nothing',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Main heading
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 32,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: 'Write it '),
                  TextSpan(
                    text: 'down.',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tagline
            const Text(
              'A structured home for every fleeting thought, half-finished idea, and meeting scribble.',
              style: TextStyle(fontFamily: 'Merriweather', fontSize: 14),
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 40),

            // Counters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(' 0  NOTES', style: TextStyle(color: Colors.grey)),
                Text(' 0  COLLECTIONS', style: TextStyle(color: Colors.grey)),
                Text('0  DAYS', style: TextStyle(color: Colors.grey)),
              ],
            ),
            // nice widget here!!!!
            const Spacer(),
            // Buttons
            Center(
              child: Column(
                children: [
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
                      print("Begin writing tapped");
                    },
                    child: const Text('Begin writing →'),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Sign in tapped");
                    },
                    child: const Text('Already have an account? Sign in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
