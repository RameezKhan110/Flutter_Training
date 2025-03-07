import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_training/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

import 'features/account/account_page.dart';
import 'features/cart/cart_page.dart';
import 'features/home/home_page.dart';
import 'features/search/search_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String name = dotenv.env['NAME'] ?? 'Ali';
  print(name);

  runApp(
      EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        startLocale: Locale('en'),
        fallbackLocale: Locale('en'),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
