import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  // QueryDocumentSnapshot<Object?> doc,
  NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  String dropdownValue = 'Business';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat.yMMMd().format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
        backgroundColor: Color(0xFF46539E),
        appBar: AppBar(
          backgroundColor: Color(0xFF46539E),
          elevation: 0.0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Add a new thing",
                style: TextStyle(fontSize: 25, color: Colors.white),
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
                Center(
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(Icons.add_business_sharp,
                        size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  //Use of SizedBox
                  height: 50.0,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFF46539E),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'Business',
                      'Personal',
                      'Food',
                      'Health',
                      'Education',
                      'Travel',
                      'Others'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  //Use of SizedBox
                  height: 10.0,
                ),
                TextField(
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  controller: _titleController,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                    hintText: 'Add title',
                    hintStyle: TextStyle(color: Colors.white),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _titleController.clear();
                      },
                      icon: const Icon(Icons.clear, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  //Use of SizedBox
                  height: 20.0,
                ),
                SafeArea(
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    controller: _contentController,
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    decoration: InputDecoration(
                      hintText: 'Add content',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _contentController.clear();
                        },
                        icon: const Icon(Icons.clear, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  //Use of SizedBox
                  height: 20.0,
                ),
                TextField(
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  controller: _placeController,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                    hintText: 'Add Place',
                    hintStyle: TextStyle(color: Colors.white),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _placeController.clear();
                      },
                      icon: const Icon(Icons.clear, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  //Use of SizedBox
                  height: 20.0,
                ),
                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: _dateController,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                    hintText: 'Select date',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon:
                          const Icon(Icons.calendar_today, color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //Use of SizedBox
                  height: 20.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection("Notes").add({
                        "userId": user!.email,
                        "note_title": _titleController.text == ""
                            ? "Untitled"
                            : _titleController.text.capitalizeFirst,
                        "note_content": _contentController.text == ""
                            ? ""
                            : _contentController.text,
                        "creation_date": _dateController.text == ""
                            ? DateFormat.yMMMd().format(DateTime.now())
                            : _dateController.text,
                        "place": _placeController.text == ""
                            ? ""
                            : _placeController.text,
                        "category": dropdownValue,
                      }).then((value) {
                        Navigator.pop(context);
                      }).catchError((error) {
                        print("Failed to add note: $error");
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF2EBAEF)), // set background color
                      elevation:
                          MaterialStateProperty.all<double>(5), // set elevation
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: const Text('ADD YOUR THING'),
                  ),
                )
              ],
            ),
          ),
        )
        );
  }
}
