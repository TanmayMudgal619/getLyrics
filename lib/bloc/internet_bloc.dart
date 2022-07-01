import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final _connectivity;

  late StreamSubscription<ConnectivityResult> _streamSubscription;
  InternetBloc(this._connectivity) : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      _streamSubscription =
          _connectivity.onConnectivityChanged.listen((connectivityResult) {
        if (connectivityResult == ConnectivityResult.none) {
          emitLost();
        } else {
          emitConnected();
        }
      });
    });
  }
  void emitLost() {
    emit(InternetLost());
  }

  void emitConnected() {
    emit(InternetConnected());
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
