import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getlyrics/storage.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  // final Storage storage = Storage();
  StorageBloc() : super(StorageInitial()) {
    on<StorageEvent>((event, emit) {});
  }
}
