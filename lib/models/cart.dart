import 'package:flutter/foundation.dart';

import 'catalog.dart';

class CartModel extends ChangeNotifier
//extending ChangeNotifier means ChangeNotifier is the super class  

 {
  ///the private field backing [catalog]
  late CatalogModel _catalog;

  //internal, private state of the class.Stores the ids of the each item
  final List<int> _itemIds = [];
  //the current catalog, Used to construct items from numeric ids
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    //notifyListeners, in case the new catalog provides information defferent from the previous one,
    //for example availability of an item might have changed.
    notifyListeners(); //call this method when ever the object changers to notify any clients the object may have changes
  }

  //set and get the list from app state provider

//list of items in the cart
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

//we can write any name for "id" it's just an element 
//_catalog.getById(int id) will access the super class variable

  ///the current total price of all items
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //current.price will give the total price

  ///adds [item] to cart. this is the only way to modify the cart from outside
  void add(Item item) {
    _itemIds.add(item.id);
    //this line tells [Model] that it should rebuild the widgets that depends on it
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    //don't forget to tell dependant widget to rebuild _every time we change the model
    notifyListeners();
  }
}
