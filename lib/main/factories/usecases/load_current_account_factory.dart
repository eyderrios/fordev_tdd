import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

class LoadCurrentAccountFactory {
  static LoadCurrentAccount makeLocalLoadCurrentAccount() {
    return LocalLoadCurrentAccount(
        fetchSecureCacheStorage:
            SecureStorageAdapterFactory.makeSecureStorageAdapter());
  }
}
