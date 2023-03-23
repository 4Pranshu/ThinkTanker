import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black45,
                            width: 2,
                          ),
                        ),
                        child: setIcon(doc,true)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 160,
                          child: Text(doc['note_title'],
                          overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: 150,
                          child: Text(doc['place'],
                          overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                    Text(doc['creation_date'],
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.normal)),
                  ],
                ),
              ]),
        ),
      ));
}

Icon setIcon(QueryDocumentSnapshot doc,bool col) {
  if (doc['category'] == "Business") {
    return Icon(
      Icons.business,
      size: 40,
      color: col==true ? Colors.blue:Colors.white,
    );
  } else if (doc['category'] == "Personal") {
    return  Icon(
      Icons.person,
      size: 40,
      color: col==true ? Colors.blue:Colors.white,
    );
  } else if (doc['category'] == "Food") {
    return  Icon(
      Icons.food_bank,
      size: 40,
      color: col==true ? Colors.blue:Colors.white,
    );
  } else if (doc['category'] == "Health") {
    return  Icon(
      Icons.health_and_safety,
      size: 40,
      color: col==true ? Colors.blue:Colors.white,
    );
  } else if (doc['category'] == "Education") {
    return  Icon(
      Icons.school,
      size: 40,
      color: col==true ? Colors.blue:Colors.white,
    );
  }
  else if(doc['category'] == "Travel"){
    return  Icon(
      Icons.flight,
      size: 40,
      color: col==true ? Colors.blue:Colors.white,
    );
  }
  return  Icon(
    Icons.note,
    size: 40,
    color: Colors.blue,
  );
}
