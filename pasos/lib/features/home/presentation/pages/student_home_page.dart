import 'package:flutter/material.dart';
import 'package:pasos/features/home/presentation/widgets/student_home_content.dart';
import 'package:pasos/shared/theme/app_colors.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const StudentHomeContent(),
    );
  }
}
