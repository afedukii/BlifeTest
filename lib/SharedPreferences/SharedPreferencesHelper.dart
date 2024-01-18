import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesHelper{
  late SharedPreferences prefs;
  SharedPreferencesHelper();

  Future<void> SharedPrefsInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveData(key,data)async{
    await prefs.setString(key, data);
  }
  void saveDataList(key,data)async{
    await prefs.setStringList(key, data);
  }

  Future<String?> getData(key)async{
    return prefs.getString(key);
  }
  Future<List<String>?> getDataList(key)async{
    return prefs.getStringList(key);
  }

  void delData(key) async{
    await prefs.remove('counter');
  }
}