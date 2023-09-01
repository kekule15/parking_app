import 'dart:convert';

import 'package:parking_app/model/user_model.dart';
import 'package:parking_app/utils/temporary_storage.dart';


class UserAuthDB {
  static const _profile = 'profile';

  static UserModel? getProfile() {
    final data = LocalStorageManager.getString(key: _profile);
    if (data.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  static Future addProfile(UserModel model) async {
    await LocalStorageManager.setString(
        key: _profile, value: jsonEncode(model.toJson()));
  }

  static Future deleteProfile() async {
    await LocalStorageManager.eraseData(key: _profile);
  }
}
