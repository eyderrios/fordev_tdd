import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

class SaveCurrentAccountFactory {
  static SaveCurrentAccount makeLocalSaveCurrentAccount() {
    return LocalSaveCurrentAccount(
      saveSecureCacheStorage:
          LocalStorageAdapterFactory.makeLocalStorageAdapater(),
    );
  }
}
