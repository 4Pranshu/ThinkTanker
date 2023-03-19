import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:think_tanker/styles/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doc['note_title'], style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
            SizedBox(height: 5.0),
            Text(doc['creation_date'], style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
            SizedBox(height: 10.0),
            Text(
              doc['note_content'],
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    ),
  );
}
