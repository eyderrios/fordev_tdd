import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../infra/cache/cache.dart';

class SecureStorageAdapterFactory {
  static SecureStorageAdapter makeSecureStorageAdapter() {
    return SecureStorageAdapter(secureStorage: const FlutterSecureStorage());
  }
}
