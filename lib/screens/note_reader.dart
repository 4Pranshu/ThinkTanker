// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:think_tanker/styles/app_style.dart';

import 'note_editor.dart';

class NoteReaderScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;
  NoteReaderScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.doc['note_title']);
    _contentController =
        TextEditingController(text: widget.doc['note_content']);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Notes').doc(widget.doc.id);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 220,
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    docRef.delete();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.doc['creation_date'],
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 15.0,
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TextField(
                      maxLines: null,
                      controller: _contentController,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              DocumentReference docref = FirebaseFirestore.instance
                  .collection('Notes')
                  .doc(widget.doc.id);
              docref.update({
                "note_title": _titleController.text == ""
                    ? "Untitled"
                    : _titleController.text.capitalizeFirst,
                "note_content": _contentController.text == ""
                    ? "No Content"
                    : _contentController.text,
                "creation_date": DateFormat.yMMMd().format(DateTime.now()),
                "color_id": colorId,
              }).then((value) {
                Navigator.pop(context);
              }).catchError((error) {
                print("Failed to edit note: $error");
                Navigator.pop(context);
              });
            },
            backgroundColor: AppStyle.cardsColor[widget.doc['color_id']],
            child: const Icon(Icons.save_as_rounded, color: Colors.black)));
  }
}
