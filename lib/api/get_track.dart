import 'dart:convert';
import 'package:getlyrics/model/track_model.dart';
import 'package:http/http.dart' as https;

const api = "938f92ef598fdedcc7ccb99fc87ddd93";

Future<Track> getTrack(trackId) async {
  var url = Uri.https("api.musixmatch.com", "/ws/1.1/track.get",
      {"apikey": api, "track_id": trackId.toString()});
  var result = await https.get(url);
  if (result.statusCode == 200) {
    return Track.fromJson(jsonDecode(result.body)["message"]["body"]["track"]);
  } else {
    throw result.statusCode;
  }
}
