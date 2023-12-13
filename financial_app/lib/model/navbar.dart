import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavBar extends StatelessWidget {
  final User user;// Accept FirebaseAuth as a parameter

  NavBar(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            accountName: null,
            accountEmail: Text(user.email!),
            currentAccountPicture: const Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.black,
            child: const Text(
              'Sign out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
