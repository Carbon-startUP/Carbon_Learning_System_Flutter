import 'package:flutter/material.dart';
import 'package:pasos/features/exams/data/models/exam_result_model.dart';
import 'package:pasos/features/exams/presentation/widgets/exam_result_card.dart';
import 'package:pasos/shared/theme/app_spacing.dart';

class ExamResultsList extends StatelessWidget {
  final List<ExamResultModel> results;

  const ExamResultsList({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ExamResultCard(result: results[index]);
      },
    );
  }
}
