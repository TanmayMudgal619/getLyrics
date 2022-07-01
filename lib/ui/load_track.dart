import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getlyrics/api/get_track.dart';
import 'package:getlyrics/bloc/internet_bloc.dart';
import 'package:getlyrics/ui/track.dart';

class LoadTrack extends StatefulWidget {
  final String id;
  final InternetBloc internetBloc;
  const LoadTrack({Key? key, required this.id, required this.internetBloc})
      : super(key: key);

  @override
  State<LoadTrack> createState() => _LoadTrackState();
}

class _LoadTrackState extends State<LoadTrack> {
  @override
  void initState() {
    getTrack(widget.id).then(
      (value) => Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) =>
              TrackDetail(track: value, internetBloc: widget.internetBloc),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
