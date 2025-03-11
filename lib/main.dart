import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_training/navigation/app_router.dart';
import 'package:flutter_training/provider/bottom_nav_provider.dart';
import 'package:flutter_training/provider/account_provider.dart';
import 'package:flutter_training/provider/search_provider.dart';
import 'package:flutter_training/provider/remote_config_provider.dart';
import 'package:flutter_training/dio/rest_api_service.dart';
import 'package:flutter_training/utils/get_storage_helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  String name = dotenv.env['NAME'] ?? 'Khan';
  print(name);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RemoteConfigProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder:
          ((context, provider, child) => Scaffold(
            bottomNavigationBar: bottomNavBar(context),
            body: provider.pages[provider.pageIndex],
          )),
    );
  }

  Consumer<BottomNavProvider> bottomNavBar(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder:
          ((context, provider, child) => SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    provider.changePageIndex(0);
                  },
                  enableFeedback: false,
                  icon: Icon(Icons.home_filled),
                ),

                IconButton(
                  onPressed: () {
                    provider.changePageIndex(1);
                  },
                  enableFeedback: false,
                  icon: Icon(Icons.search),
                ),

                IconButton(
                  onPressed: () {
                    provider.changePageIndex(2);
                  },
                  enableFeedback: false,
                  icon: Icon(Icons.shopping_bag_outlined),
                ),

                IconButton(
                  onPressed: () {
                    provider.changePageIndex(3);
                  },
                  enableFeedback: false,
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          )),
    );
  }
}
