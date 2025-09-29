import 'package:flutter/material.dart';
import 'package:pasos/features/home/presentation/widgets/parent_home_content.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import '../widgets/home_app_bar.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(title: 'لوحة تحكم ولي الأمر'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ParentContent(),
      ),
    );
  }
}
