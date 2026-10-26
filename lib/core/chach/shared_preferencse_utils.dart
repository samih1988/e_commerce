import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class SharedPreferencseUtils {
 static  late  SharedPreferences _preferneces;

 static Future<SharedPreferences> init() async {
    return _preferneces = await SharedPreferences.getInstance();
  }

// todo: save data
  Future<bool> saveData({required String key, dynamic value}) async {
    if (value is int) {
      return await _preferneces.setInt(key, value);
    } else if (value is double) {
      return await _preferneces.setDouble(key, value);
    } else if (value is String) {
      return await _preferneces.setString(key, value);
    } else if (value is bool) {
      return await _preferneces.setBool(key, value);
    } else if (value is List<String>) {
      return await _preferneces.setStringList(key, value);
    } else if (value == null) {
      return await removeData(key: key);
    } else {
      return false;
    }
  }

// todo: get data
  Object? getData({required String key}) {
    return _preferneces.get(key);
  }

  String? getString(String key) => _preferneces.getString(key);
  bool? getBool(String key) => _preferneces.getBool(key);
  int? getInt(String key) => _preferneces.getInt(key);
  double? getDouble(String key) => _preferneces.getDouble(key);
  List<String>? getStringList(String key) => _preferneces.getStringList(key);
  bool containsKey(String key) => _preferneces.containsKey(key);

// todo: remove data
  Future<bool> removeData({required String key}) async {
    return await _preferneces.remove(key);
  }

  Future<bool> clear() async {
    return await _preferneces.clear();
  }
}
