import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getlyrics/api/get_lyrics.dart';
import 'package:getlyrics/bloc/internet_bloc.dart';
import 'package:getlyrics/model/track_model.dart';

class TrackDetail extends StatefulWidget {
  final Track track;
  final InternetBloc internetBloc;
  const TrackDetail({Key? key, required this.track, required this.internetBloc})
      : super(key: key);

  @override
  State<TrackDetail> createState() => _TrackDetailState();
}

class _TrackDetailState extends State<TrackDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.track.trackName),
      ),
      body: BlocProvider(
        create: (_) => widget.internetBloc,
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
                  Text("No Internet"),
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
                ? (FutureBuilder<String>(
                    future: getLyricsApi(widget.track.trackId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          return SingleChildScrollView(
                            child: Text(snapshot.requireData),
                          );
                      }
                    },
                  ))
                : (const Text("No Lyrics......")),
          ))
        ],
      ),
    );
  }
}
