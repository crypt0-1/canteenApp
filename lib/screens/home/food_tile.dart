import 'package:flutter/material.dart';
import 'package:firebase/models/food.dart';

class Food extends StatelessWidget {
  final Ice item;
  Food({this.item});
  @override
  Widget build(BuildContext context) {
    return Padding(
padding: EdgeInsets.only(top:8),
child: Card(
  margin: EdgeInsets.fromLTRB(20, 6, 20,6),
  child: ListTile(
    leading: CircleAvatar(radius: 25,backgroundColor: Colors.pink),
    title: Text(item.name),
    subtitle: Text('Ordered ${item.dishs}'),
  ),
  ),

    );
  }
}