import 'package:flutter/material.dart';

class CatalogModel {
  //in a real app this might be a backed by a backend and cached on device .
  //In this sample app catalog is procedurally generated and infinite
  //the catalog is expected to be immutable( no products are expected to be added, removed , or change during the excecution  of app
  //immutable - whose object can't be adjusted after it is changed 
  static List<String> itemNames = [
    'Codesmell',
    'Control flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  //get the item by [id]
  //in this sample catelog is infinite, looping over [itemNames]

  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  Item getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)

      //to make the sample app look nicer,
      //each item is given one of the material design primary color
      : color = Colors.primaries[id % Colors.primaries.length];

//override hashcode
//super class of any class is object 
//getter,returns the hash code of an object 
  @override
  int get hashcode => id;

//we should generally implement operator ==if we override hashcode
//if we need to compare 2 defferent objects we use this
  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
