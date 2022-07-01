import 'dart:convert';

import 'package:getlyrics/model/track_model.dart';
import 'package:http/http.dart' as https;

const api = "938f92ef598fdedcc7ccb99fc87ddd93";

Future<List<Track>> getHomeScreenData() async {
  var url = Uri.https(
      "api.musixmatch.com", "/ws/1.1/chart.tracks.get", {"apikey": api});
  var result = await https.get(url);
  if (result.statusCode == 200) {
    List<Track> data = [];
    jsonDecode(result.body)["message"]["body"]["track_list"].forEach((e) {
      data.add(Track.fromJson(e["track"]));
    });
    return data;
  } else {
    throw result.statusCode;
  }
}
