abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final dynamic data;

  HomeLoaded({required this.data});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
