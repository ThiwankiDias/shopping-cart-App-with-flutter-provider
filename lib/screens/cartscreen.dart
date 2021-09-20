import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_provider/models/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _cartList(),
              ),
            ),
            const Divider(
              height: 4,
              color: Colors.black,
            ),
            _cartTotal(),
          ],
        ),
      ),
    );
  }
}

class _cartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //another way to listen to the model's change is to include the consumer Widget. This widget will automatically
            //listen to cart model and return it's builder on every change
            //the importent thing is it will not rebuild the rest of the widget in this build method
            Consumer<CartModel>(builder: (context, cart, child) {
              return Text(
                '\$${cart.totalPrice}',
                style: hugeStyle,
              );
            }),
            const SizedBox(
              width: 24,
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("buying not supported yet")));
              },
              child: Text('Buy'),
              style: TextButton.styleFrom(primary: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class _cartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    var cart = context.watch<CartModel>();
    return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.done),
            trailing: IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                cart.remove(cart.items[index]);
              },
            ),
            title: Text(
              cart.items[index].name,
              style: itemNameStyle,
            ),
          );
        });
  }
}
