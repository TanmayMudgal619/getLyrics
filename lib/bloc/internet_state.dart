part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetLost extends InternetState {}

class InternetConnected extends InternetState {}
