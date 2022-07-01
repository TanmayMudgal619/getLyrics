import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getlyrics/bloc/home_bloc.dart';
import 'package:getlyrics/bloc/internet_bloc.dart';
import 'package:getlyrics/model/track_model.dart';
import 'package:getlyrics/ui/track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();
  final InternetBloc _internetBloc = InternetBloc(Connectivity());
  @override
  void initState() {
    _internetBloc.add(InternetEvent());
    _homeBloc.add(LoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("getLyrics"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _homeBloc,
          ),
          BlocProvider(
            create: (_) => _internetBloc,
          ),
        ],
        child: BlocBuilder<InternetBloc, InternetState>(
          bloc: _internetBloc,
          builder: (context, state) {
            if (state is InternetInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is InternetLost) {
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
            }
            return BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, state) {
                if (state is HomeInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeLoadingDone) {
                  return Container(
                    child: _buildHome(context, state.homeScreenData),
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Text(state.errorCode),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHome(context, List<Track> homeData) {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: homeData
          .map(
            (e) => ListTile(
              isThreeLine: true,
              dense: true,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TrackDetail(
                      track: e,
                      internetBloc: _internetBloc,
                    ),
                  ),
                );
              },
              leading: const Icon(Icons.music_note),
              title: Text(
                e.trackName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.albumName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    e.artistName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark),
              ),
            ),
          )
          .toList(),
    );
  }
}
