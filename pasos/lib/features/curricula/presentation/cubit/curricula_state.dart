import 'package:equatable/equatable.dart';
import 'package:pasos/features/curricula/data/models/curriculum_model.dart';

abstract class CurriculaState extends Equatable {
  const CurriculaState();

  @override
  List<Object> get props => [];
}

class CurriculaInitial extends CurriculaState {}

class CurriculaLoading extends CurriculaState {}

class CurriculaLoaded extends CurriculaState {
  final List<CurriculumModel> curricula;

  const CurriculaLoaded(this.curricula);

  @override
  List<Object> get props => [curricula];
}

class CurriculaError extends CurriculaState {
  final String message;

  const CurriculaError(this.message);

  @override
  List<Object> get props => [message];
}
