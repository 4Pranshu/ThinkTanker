import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    return Drawer(
      backgroundColor:Colors.grey.shade900.withOpacity(0.95),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/nav.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.colorBurn,
                  ),
                ),
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
              ),
              ),
          ListTile(
            title: Text("Exit",style: TextStyle(color:Colors.white,fontSize: 20.0,),),
            leading : Icon(Icons.exit_to_app,color: Colors.white,size:25,),
            onTap:(){
              SystemNavigator.pop();
            },

          )
        ],
      ),
    );
  }
}
