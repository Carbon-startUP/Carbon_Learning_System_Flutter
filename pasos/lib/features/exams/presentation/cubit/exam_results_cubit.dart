import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/exams/data/repositories/exam_repository.dart';
import 'exam_results_state.dart';

class ExamResultsCubit extends Cubit<ExamResultsState> {
  final ExamRepository examRepository;

  ExamResultsCubit(this.examRepository) : super(ExamResultsInitial());

  Future<void> fetchExamResults() async {
    try {
      emit(ExamResultsLoading());
      final results = await examRepository.getExamResults();
      emit(ExamResultsLoaded(results));
    } catch (e) {
      emit(ExamResultsError('فشل في تحميل نتائج الامتحانات.'));
    }
  }
}
