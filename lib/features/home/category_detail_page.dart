import 'package:flutter/material.dart';
import 'package:flutter_training/navigation/app_paths.dart';
import 'package:go_router/go_router.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppPaths.home),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
