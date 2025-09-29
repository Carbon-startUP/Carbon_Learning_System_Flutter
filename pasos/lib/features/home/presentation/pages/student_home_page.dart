import 'package:flutter/material.dart';
import 'package:pasos/features/home/presentation/widgets/student_home_content.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import '../widgets/home_app_bar.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeAppBar(title: 'لوحة تحكم الطالب'),
      body: const StudentHomeContent(),
    );
  }
}
