import 'package:myshowfilm/src/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  //singleton de las preferencias
  static final SharePrefs instance = SharePrefs._interal();

  SharePrefs._interal();

  factory SharePrefs() => instance;

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set provider(String value) => _prefs.setString(Constants.PROVIDER, value);
  get provider {
    return _prefs.getString(Constants.PROVIDER);
  }
}
