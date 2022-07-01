import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getlyrics/api/get_lyrics.dart';
import 'package:getlyrics/bloc/internet_bloc.dart';
import 'package:getlyrics/bloc/lyrics_bloc.dart';
import 'package:getlyrics/model/track_model.dart';
import 'package:getlyrics/storage.dart';

class TrackDetail extends StatefulWidget {
  final Track track;
  final InternetBloc internetBloc;
  const TrackDetail({Key? key, required this.track, required this.internetBloc})
      : super(key: key);

  @override
  State<TrackDetail> createState() => _TrackDetailState();
}

class _TrackDetailState extends State<TrackDetail> {
  late LyricsBloc _lyricsBloc;
  @override
  void initState() {
    _lyricsBloc = LyricsBloc(widget.track.trackId);
    _lyricsBloc.add(GetLyrics());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.track.trackName),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => widget.internetBloc,
          ),
          BlocProvider(create: (_) => _lyricsBloc)
        ],
        child: BlocBuilder(
          bloc: widget.internetBloc,
          builder: (context, state) {
            if (state is InternetConnected) {
              return _trackDetails();
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.signal_cellular_connected_no_internet_0_bar_rounded,
                    size: 70,
                  ),
                  Text("No Internet Connection"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _trackDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          const Icon(
            Icons.album,
            size: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.track.trackName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.track.artistName),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Center(
            child: (widget.track.hasLyrics == 1)
                ? (BlocBuilder(
                    bloc: _lyricsBloc,
                    builder: (context, state) {
                      if (state is LyricsInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LyricsLoaded) {
                        return Text(state.lyrics);
                      } else if (state is LyricsError) {
                        return Center(
                          child: Text(state.errorCode),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ))
                : (const Text("No Lyrics......")),
          ))
        ],
      ),
    );
  }
}
