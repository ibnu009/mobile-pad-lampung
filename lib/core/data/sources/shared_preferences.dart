import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const tokenKey = 'token';
const isIntroducedKey = 'is.introduced';

class AppPreferences {
  final FlutterSecureStorage storage;

  AppPreferences(this.storage);

  Future<void> writeSecureData(String key, String value) {
    print('writing for data from key $key');

    var writeData = storage.write(key: key, value: value);
    return writeData;
  }

  Future<String?> readSecureData(String key) {

    print('asking for data from key $key');

    var readData = storage.read(key: key);
    return readData;
  }

  Future<void> deleteSecureData(String key) {
    print('deleting for data from key $key');

    var deleteData = storage.delete(key: key);
    return deleteData;
  }
}
