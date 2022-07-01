import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  late SharedPreferences _preferences;
  late List<String> ids;
  late List<String> names;
  void initStorage() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getBool("setUp") ?? false) {
      setStorage();
    }
    ids = _preferences.getStringList("track_ids") ?? [];
    names = _preferences.getStringList("track_names") ?? [];
  }

  void setStorage() {
    _preferences.setBool("setUp", true);
    _preferences.setStringList("track_ids", []);
    _preferences.setStringList("track_names", []);
  }

  void addTrack(id, name) {
    ids.add(id);
    names.add(name);
    _preferences.setStringList("track_ids", ids);
    _preferences.setStringList("track_names", names);
  }

  void removeTrack(id, name) {
    ids.remove(id);
    names.remove(name);
    _preferences.setStringList("track_ids", ids);
    _preferences.setStringList("track_names", names);
  }
}

Storage storage = Storage();
