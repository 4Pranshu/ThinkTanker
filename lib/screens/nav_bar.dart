import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration:  const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/main.png"),
                  fit: BoxFit.cover,
                ),
                // color: Colors.blue.shade900,
              ),
              accountName: Text(
                user!.displayName.toString(),
                style: const TextStyle(
                  fontSize: 30.0,
                ),
              ),
              accountEmail: Text(
                user.email.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL.toString()),
              )),
              
              
        ],
      ),
    );
  }
}
