import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../infra/cache/cache.dart';

class LocalStorageAdapterFactory {
  static LocalStorageAdapter makeLocalStorageAdapater() {
    return LocalStorageAdapter(secureStorage: const FlutterSecureStorage());
  }
}
