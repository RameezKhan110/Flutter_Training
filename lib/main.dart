import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_training/dio/rest_api_service.dart';
import 'package:flutter_training/features/account/account_page.dart';
import 'package:flutter_training/features/cart/cart_page.dart';
import 'package:flutter_training/features/home/home_page.dart';
import 'package:flutter_training/features/search/search_page.dart';
import 'package:flutter_training/navigation/app_router.dart';
import 'package:flutter_training/provider/account_cubit.dart';
import 'package:flutter_training/provider/bottom_nav_cubit.dart';
import 'package:flutter_training/provider/cart_cubit.dart';
import 'package:flutter_training/provider/remote_config_cubit.dart';
import 'package:flutter_training/provider/search_cubit.dart';
import 'package:flutter_training/utils/graphql_service.dart';
import 'package:flutter_training/utils/collection_query.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  String name = dotenv.env['NAME'] ?? 'Khan';
  print(name);

  final graphQLService = GraphQLService();
  final response = await graphQLService.query(collectionsQuery);
  print("graph_ql data ${response.data}");

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(RestApiService()),
          ),
          BlocProvider<AccountCubit>(
            create: (context) => AccountCubit(RestApiService()),
          ),
          BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit()),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(RestApiService()),
          ),
          BlocProvider<RemoteConfigCubit>(
            create: (context) => RemoteConfigCubit(),
          ),
        ],
        child: MyApp(),
      ),
    ),
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

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: bottomNavBar(context),
          body:
              state.pageIndex == 0
                  ? Homepage()
                  : state.pageIndex == 1
                  ? SearchPage()
                  : state.pageIndex == 2
                  ? CartPage()
                  : AccountPage(),
        );
      },
    );
  }

  BlocBuilder<BottomNavCubit, BottomNavState> bottomNavBar(
    BuildContext context,
  ) {
    var cubit = context.read<BottomNavCubit>();
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  cubit.changePageIndex(0);
                },
                enableFeedback: false,
                icon: Icon(Icons.home_filled),
              ),

              IconButton(
                onPressed: () {
                  cubit.changePageIndex(1);
                },
                enableFeedback: false,
                icon: Icon(Icons.search),
              ),

              IconButton(
                onPressed: () {
                  cubit.changePageIndex(2);
                },
                enableFeedback: false,
                icon: Icon(Icons.shopping_bag_outlined),
              ),

              IconButton(
                onPressed: () {
                  cubit.changePageIndex(3);
                },
                enableFeedback: false,
                icon: Icon(Icons.person),
              ),
            ],
          ),
        );
      },
    );
  }
}
