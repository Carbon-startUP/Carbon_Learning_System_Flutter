import 'package:equatable/equatable.dart';
import '../../data/models/advertisement_model.dart';

abstract class AdvertisementsState extends Equatable {
  const AdvertisementsState();

  @override
  List<Object?> get props => [];
}

class AdvertisementsInitial extends AdvertisementsState {}

class AdvertisementsLoading extends AdvertisementsState {}

class AdvertisementsLoaded extends AdvertisementsState {
  final List<AdvertisementModel> advertisements;
  final String? selectedCategory;

  const AdvertisementsLoaded({
    required this.advertisements,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [advertisements, selectedCategory];
}

class AdvertisementsError extends AdvertisementsState {
  final String message;

  const AdvertisementsError(this.message);

  @override
  List<Object?> get props => [message];
}
