import 'dart:convert';

import 'package:login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPlayerRepository implements PlayerRepository {
  static const _key = 'player';

  final SharedPreferences _sharedPreferences;
  final PlayerMapper _mapper = PlayerMapper();

  SharedPreferencesPlayerRepository(this._sharedPreferences);

  @override
  Future<void> clear() async {
    await _sharedPreferences.remove(_key);
  }

  @override
  Future<Player?> get() async {
    final jsonString = _sharedPreferences.getString(_key);
    if (jsonString == null) return null;
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    return _mapper.fromJson(map);
  }

  @override
  Future<void> save(Player player) async {
    final jsonString = jsonEncode(_mapper.toJson(player));
    await _sharedPreferences.setString(_key, jsonString);
  }
}

class PlayerMapper {
  Player fromJson(Map<String, dynamic> json) => Player(name: json['name'] as String);

  Map<String, dynamic> toJson(Player player) => {'name': player.name};
}
