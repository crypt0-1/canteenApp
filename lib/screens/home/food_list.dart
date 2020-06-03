import 'package:firebase/screens/home/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/models/food.dart';
class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<List<Ice>>(context) ?? [];
    //print(foods.documents);
  
    return ListView.builder(
       itemCount: foods.length,
       itemBuilder: (context,index){
         return Food(item:foods[index]);

    },);
  }
}