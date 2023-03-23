import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:think_tanker/widgets/note_card.dart';

import 'nav_bar.dart';
import 'note_editor.dart';
import 'note_reader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      drawer: MyNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: Text(
          "ThinkTanker",
          style: GoogleFonts.adventPro(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Image(image: AssetImage("assets/images/main2.jpeg"),
                fit: BoxFit.fitWidth
                
                ),
              ),
              Positioned(
                top: 175,
                left: 20,
                child: Text(
                  "Your",
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontSize: 30),
                ),
              ),
              Positioned(
                top: 200,
                left: 30,
                child: Text(
                  "Things",
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontSize: 30),
                ),
              ),
              Positioned(
                top: 210,
                right: 10,
                child: Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontSize: 20),
                ),
              )
            ]),
            const SizedBox(
              height: 10.0,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "INBOX",
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("Notes")
                      .where("userId", isEqualTo: user?.email)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var note = snapshot.data!.docs[index];
                            return Column(children: [
                              noteCard(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NoteReaderScreen(
                                      doc: note,
                                    ),
                                  ),
                                );
                              }, note),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              )
                            ]);
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "There is no notes",
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 40),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NoteEditorScreen();
          }));
        },
        backgroundColor: Color(0xFF2EBAEF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
