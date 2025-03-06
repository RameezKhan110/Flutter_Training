import 'package:flutter/material.dart';

import 'features/account/account_page.dart';
import 'features/cart/cart_page.dart';
import 'features/home/home_page.dart';
import 'features/search/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ParentPage(),
    );
  }
}

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {

  var pageIndex = 0;
  final pages = [Homepage(), SearchPage(), CartPage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(context),
      body: pages[pageIndex],
    );
  }

  SizedBox bottomNavBar(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            enableFeedback: false,
            icon: Icon(Icons.home_filled),
          ),

          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              enableFeedback: false,
              icon: Icon(Icons.search)
          ),


          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              enableFeedback: false,
              icon: Icon(Icons.shopping_bag_outlined)
          ),


          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              enableFeedback: false,
              icon: Icon(Icons.person)
          )
        ],
      ),
    );

  }
}
