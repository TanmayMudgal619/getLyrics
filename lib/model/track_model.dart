class Track {
  final int trackId;
  final String trackName;
  final int trackRating;
  final int hasLyrics;
  final int isExplicit;
  final int artistId;
  final String artistName;
  final int albumId;
  final String albumName;

  const Track(
    this.trackId,
    this.trackName,
    this.trackRating,
    this.hasLyrics,
    this.isExplicit,
    this.artistId,
    this.artistName,
    this.albumId,
    this.albumName,
  );

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      json["track_id"],
      json["track_name"],
      json["track_rating"],
      json["has_lyrics"],
      json["explicit"],
      json["artist_id"],
      json["artist_name"],
      json["album_id"],
      json["album_name"],
    );
  }
}
