import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdev/Hompage/folio_Homepage.dart';
import 'package:flutterappdev/Hompage/leaves_Hompage.dart';
import 'package:flutterappdev/services/auth/bloc/auth_bloc.dart';
import 'package:flutterappdev/services/auth/firebase_auth_provider.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  int _selectedIndex = 2;
  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LeavesHomePage()),
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
    return BlocProvider(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: Scaffold(
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
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: 40,
                  height: 40,
                ),
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
              const SizedBox(height: 30),
              const Text(
                'Free forever · No account needed to start',
                style: TextStyle(fontSize: 12, color: Colors.grey),
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
