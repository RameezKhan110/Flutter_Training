import 'package:flutter_training/features/home/category_detail_page.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/navigation/app_paths.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPaths.home,
    routes: [
      GoRoute(
        path: AppPaths.home,
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        path: AppPaths.categoryDetail,
        builder: (context, state) => CategoryDetailPage(),
      ),
    ],
  );
}
