import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/exams/data/repositories/exam_repository.dart';
import 'package:pasos/features/exams/presentation/cubit/exam_results_cubit.dart';
import 'package:pasos/features/exams/presentation/cubit/exam_results_state.dart';
import 'package:pasos/features/exams/presentation/widgets/exam_results_list.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class ExamResultsPage extends StatelessWidget {
  const ExamResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExamResultsCubit(ExamRepository())..fetchExamResults(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('نتائج الامتحانات', style: AppTextStyles.titleLarge),
        ),
        body: BlocBuilder<ExamResultsCubit, ExamResultsState>(
          builder: (context, state) {
            if (state is ExamResultsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ExamResultsLoaded) {
              return ExamResultsList(results: state.results);
            }
            if (state is ExamResultsError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.bodyLarge.copyWith(color: Colors.red),
                ),
              );
            }
            return const Center(child: Text('ابدأ في تحميل النتائج.'));
          },
        ),
      ),
    );
  }
}
