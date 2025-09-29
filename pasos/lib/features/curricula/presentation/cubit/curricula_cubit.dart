import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/curricula/data/Repository/curricula_repository.dart';
import 'curricula_state.dart';

class CurriculaCubit extends Cubit<CurriculaState> {
  final CurriculaRepository _curriculaRepository;

  CurriculaCubit(this._curriculaRepository) : super(CurriculaInitial());

  Future<void> fetchCurricula() async {
    try {
      emit(CurriculaLoading());
      final curricula = await _curriculaRepository.getCurricula();
      emit(CurriculaLoaded(curricula));
    } catch (e) {
      emit(CurriculaError('فشل في تحميل المناهج الدراسية.'));
    }
  }
}
