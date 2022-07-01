import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getlyrics/api/get_lyrics.dart';

part 'lyrics_event.dart';
part 'lyrics_state.dart';

class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {
  final int trackId;
  LyricsBloc(this.trackId) : super(LyricsInitial()) {
    on<GetLyrics>((event, emit) async {
      emit(LyricsInitial());
      try {
        final lyrics = await getLyricsApi(trackId);
        emit(LyricsLoaded(lyrics));
      } catch (e) {
        emit(LyricsError(e.toString()));
      }
    });
  }
}
