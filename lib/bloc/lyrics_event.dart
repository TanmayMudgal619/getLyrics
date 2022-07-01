part of 'lyrics_bloc.dart';

abstract class LyricsEvent extends Equatable {
  const LyricsEvent();

  @override
  List<Object> get props => [];
}

class GetLyrics extends LyricsEvent {}
