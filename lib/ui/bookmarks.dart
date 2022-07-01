import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getlyrics/bloc/internet_bloc.dart';
import 'package:getlyrics/storage.dart';
import 'package:getlyrics/ui/load_track.dart';

class BookMarks extends StatefulWidget {
  final InternetBloc internetBloc;
  const BookMarks({Key? key, required this.internetBloc}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: BlocProvider(
        create: (_) => widget.internetBloc,
        child: BlocBuilder(
          bloc: widget.internetBloc,
          builder: (context, state) {
            if (state is InternetLost) {
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
            }
            return _buildMainBody(context);
          },
        ),
      ),
    );
  }

  Widget _buildMainBody(context) {
    return (storage.ids.isEmpty)
        ? (const Center(
            child: Text("Add Bookmarks"),
          ))
        : (ListView.builder(
            itemCount: storage.ids.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoadTrack(
                          id: storage.ids[index],
                          internetBloc: widget.internetBloc),
                    ),
                  );
                },
                leading: const Icon(Icons.music_note),
                title: Text(storage.names[index]),
              );
            },
          ));
  }
}
