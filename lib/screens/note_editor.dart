import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:think_tanker/styles/app_style.dart';

import 'home_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  // QueryDocumentSnapshot<Object?> doc,
  NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String dateTime = DateFormat.yMMMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Add a new note",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Image(
                image: AssetImage('assets/images/pic.png'),
                height: 50,
                width: 50,
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add title",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  controller: _titleController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  dateTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add content",
                            hintStyle: TextStyle(color: Colors.white)),
                        controller: _contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance.collection("Notes").add({
              "userId": user!.email,
              "note_title": _titleController.text == ""
                  ? "Untitled"
                  : _titleController.text.capitalizeFirst,
              "note_content":
                  _contentController.text == "" ? "" : _contentController.text,
              "creation_date": dateTime,
              "color_id": color_id,
            }).then((value) {
              Navigator.pop(context);
            }).catchError((error) {
              print("Failed to add note: $error");
            });
          },
          backgroundColor: AppStyle.cardsColor[color_id],
          child: Icon(Icons.save, color: Colors.black),
            
            
            ),    
          );
  }
}
