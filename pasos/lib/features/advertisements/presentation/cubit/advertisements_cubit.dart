import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/advertisement_repository.dart';
import 'advertisements_state.dart';

class AdvertisementsCubit extends Cubit<AdvertisementsState> {
  final AdvertisementRepository _repository;

  AdvertisementsCubit(this._repository) : super(AdvertisementsInitial());

  Future<void> loadAdvertisements() async {
    emit(AdvertisementsLoading());
    try {
      final advertisements = await _repository.getAdvertisements();
      emit(AdvertisementsLoaded(advertisements: advertisements));
    } catch (e) {
      emit(AdvertisementsError('حدث خطأ في تحميل الإعلانات'));
    }
  }

  void filterByCategory(String? category) {
    if (state is AdvertisementsLoaded) {
      final currentState = state as AdvertisementsLoaded;
      emit(
        AdvertisementsLoaded(
          advertisements: currentState.advertisements,
          selectedCategory: category,
        ),
      );
    }
  }

  Future<void> subscribe(String advertisementId) async {
    await _repository.subscribe(advertisementId);
    loadAdvertisements();
  }
}
