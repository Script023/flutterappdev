import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappdev/Hompage/leaves_Hompage.dart';
import 'package:flutterappdev/Hompage/memo_hompage.dart';
import 'package:flutterappdev/services/auth/bloc/auth_bloc.dart';
import 'package:flutterappdev/services/auth/firebase_auth_provider.dart';
import 'package:flutterappdev/views/login-views.dart';
import 'package:flutterappdev/views/register-views.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolioPage extends StatefulWidget {
  const FolioPage({super.key});
  @override
  State<FolioPage> createState() => _FolioPageState();
}

class _FolioPageState extends State<FolioPage> {
  int _selectedIndex = 2;
  void _onItemTapped(BuildContext context, int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MemoPage()),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LeavesHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo + version info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/icon.png',
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(width: 8),
                      const Text(
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
                        'EST. 2024',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        'v2.1.0',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Heading
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

              const SizedBox(height: 40),

              const Text(
                'A structured home for every fleeting thought, half-finished idea, and meeting scribble.',
                style: TextStyle(fontFamily: 'Merriweather', fontSize: 14),
              ),

              const SizedBox(height: 70),

              // Counters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('0 NOTES', style: TextStyle(color: Colors.grey)),
                  Text('0 COLLECTIONS', style: TextStyle(color: Colors.grey)),
                  Text('0 DAYS', style: TextStyle(color: Colors.grey)),
                ],
              ),

              const Spacer(),

              // Buttons
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () async {
                        await incrementIntroCounter();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const RegisterView(),
                          ),
                        );
                      },
                      child: const Text('Begin writing →'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await incrementIntroCounter();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginView()),
                        );
                      },
                      child: const Text('Already have an account? Sign in'),
                    ),
                  ],
                ),
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.brown,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _onItemTapped(context, index);
          },
        ),
      ),
    );
  }
}

Future<void> incrementIntroCounter() async {
  final prefs = await SharedPreferences.getInstance();
  int counter = prefs.getInt('intorCounter') ?? 0;
  counter++;
  await prefs.setInt('introCounter', counter);
}
