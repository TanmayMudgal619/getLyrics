part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingDone extends HomeState {
  final List<Track> homeScreenData;
  const HomeLoadingDone(this.homeScreenData);
}

class HomeError extends HomeState {
  final String errorCode;
  const HomeError(this.errorCode);
}
