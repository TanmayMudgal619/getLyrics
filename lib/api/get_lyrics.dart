import 'dart:convert';
import 'package:http/http.dart' as https;

const api = "938f92ef598fdedcc7ccb99fc87ddd93";

Future<String> getLyricsApi(int trackId) async {
  var url = Uri.https("api.musixmatch.com", "/ws/1.1/track.lyrics.get",
      {"apikey": api, "track_id": trackId.toString()});
  var result = await https.get(url);
  if (result.statusCode == 200) {
    return jsonDecode(result.body)["message"]["body"]["lyrics"]["lyrics_body"];
  } else {
    throw result.statusCode;
  }
}
