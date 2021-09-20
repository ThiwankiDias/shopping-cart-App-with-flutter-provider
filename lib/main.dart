import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_provider/common/theme.dart';
import 'package:shopping_flutter_provider/models/cart.dart';
import 'package:shopping_flutter_provider/models/catalog.dart';
import 'package:shopping_flutter_provider/screens/cartscreen.dart';
import 'package:shopping_flutter_provider/screens/catalogscreen.dart';
import 'package:shopping_flutter_provider/screens/login.dart';

//flutter sample app that provides app state management using provider package
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: apptheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //using multiprovider is convinient when providing multiple objects
    return MultiProvider(
      providers: [
        //in this sample app,catalog model never changes so a simple provider is sufficent
        Provider(create: (context) => CatalogModel()),

        //CartModel is implemented as a changeNotifier,which calls for the use of ChangeNotifierProvider
        //MoreOver CartModel depends on CatalogModel so a ProxyProvider is needed
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider',
        theme: apptheme,
        initialRoute: '/',
        routes: {
          '/': (context) => loginScreen(),
          '/catalog': (context) => CatalogScreen(),
          '/cart': (context) => CartScreen()
        },
      ),
    );
  }
}
