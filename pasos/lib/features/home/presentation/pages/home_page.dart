import 'package:flutter/material.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeAppBar(),
      body: const HomeContent(),
    );
  }
}
