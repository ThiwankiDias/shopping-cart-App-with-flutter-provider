import 'package:flutter/material.dart';
import 'package:shopping_flutter_provider/models/cart.dart';
import 'package:shopping_flutter_provider/models/catalog.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        ///creates a [scrollView] that creates custom scroll effects using slivers
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(
            //creates a sliver that contains a single box widget
            child: SizedBox(
              height: 14.0,
            ),
          ),
          SliverList(
              //creates a sliver that places box children in a linear array
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MyListItem(index: index)))
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        //creates a material design appbar that can be placed in [CustomScrollViews]
        title: Text(
          'catalog',
          style: Theme.of(context).textTheme.headline1,
        ),
        floating:
            true, //quickly reveal the appbar when they scroll "up" the list
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: const Icon(Icons.shopping_cart))
        ]);
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  const _MyListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      ///Here we are only interest in the item at [index]. we don't care about any other change
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Text(
                item.name,
                style: textTheme,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            _AddButton(item: item)
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );
    return TextButton(
        onPressed: isInCart
            ? null
            : () {
                var cart = context.read<CartModel>();
                cart.add(item);
              },style: ButtonStyle(overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if(states.contains(MaterialState.pressed)){
                    return Theme.of(context).primaryColor;
                }
                return null;

              } ),),
        child: isInCart
            ? const Icon(
                Icons.check,
                semanticLabel: "Added",
              )
            : const Text("Add"));
  }
}
