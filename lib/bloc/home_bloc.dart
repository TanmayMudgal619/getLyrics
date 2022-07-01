import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:getlyrics/api/get_tracks.dart';
import 'package:getlyrics/model/track_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadingEvent>((event, emit) async {
      try {
        emit(HomeInitial());
        final data = await getHomeScreenData();
        emit(HomeLoadingDone(data));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
