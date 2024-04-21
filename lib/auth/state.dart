import 'dart:convert';

import 'package:web/web.dart' as web;
import '../profile/model.dart';

Profile? profile;

loadLocalState() {
  String? profileData = web.window.localStorage.getItem('profile');
  if (profileData != null) {
    profile = Profile.fromJson(jsonDecode(profileData));
  }
}

storeLocalState() {
  if (profile != null) {
    String profileData = jsonEncode(profile!.toJson());
    web.window.localStorage.setItem('profile', profileData);
  }
}

clearLocalState() {
  profile = null;
  web.window.localStorage.clear();
}