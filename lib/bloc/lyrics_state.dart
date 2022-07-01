part of 'lyrics_bloc.dart';

abstract class LyricsState extends Equatable {
  const LyricsState();

  @override
  List<Object> get props => [];
}

class LyricsInitial extends LyricsState {}

class LyricsLoaded extends LyricsState {
  final String lyrics;
  const LyricsLoaded(this.lyrics);
}

class LyricsError extends LyricsState {
  final String errorCode;
  const LyricsError(this.errorCode);
}
