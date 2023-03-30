import 'package:app_loja/screens/category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryTitle({required this.snapshot});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot["icon"]),
      ),
      title: Text(
        snapshot["title"],
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              snapshot: snapshot,
            ),
          ),
        );
      },
    );
  }
}
