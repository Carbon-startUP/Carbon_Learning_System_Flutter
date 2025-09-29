import 'package:flutter/foundation.dart';
import 'package:pasos/features/exams/data/models/exam_result_model.dart';

@immutable
abstract class ExamResultsState {}

class ExamResultsInitial extends ExamResultsState {}

class ExamResultsLoading extends ExamResultsState {}

class ExamResultsLoaded extends ExamResultsState {
  final List<ExamResultModel> results;
  ExamResultsLoaded(this.results);
}

class ExamResultsError extends ExamResultsState {
  final String message;
  ExamResultsError(this.message);
}
