import 'dart:convert';

import 'package:findatutor360/utils/shared_pref.dart';
import 'package:flutter/foundation.dart';

Future<T?> runPersistedQuery<T>(
  String key,
  bool remoteOnly,
  Future<T> Function() fetchFromApi,
  T Function(Map<String, dynamic>) deserializer,
) async {
  AppPreferences appPreferences = AppPreferences();

  if (kDebugMode) {
    remoteOnly = true;
  }
  try {
    if (!remoteOnly) {
      // attempt to load from cache
      try {
        final cacheData = await appPreferences.getString(key);

        if (cacheData != null) {
          final data = jsonDecode(cacheData);

          await Future.delayed(
              const Duration(milliseconds: 200)); // add wait time
          return deserializer(data);
        }
      } catch (e) {
        print("===>error $e");
      }
    }

    try {
      T newData = await fetchFromApi();

      await appPreferences.setString(
        key,
        jsonEncode(newData),
      );
      return newData;
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  } catch (e) {
    rethrow;
  }
}
