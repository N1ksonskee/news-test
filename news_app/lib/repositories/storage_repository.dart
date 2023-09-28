import 'package:test_app/services/storage/storage.dart';

enum StorageKey { isOptimisticMarkedAllRead, optimisticMarkedReadIds }

abstract class OptimisticRepositoryInterface {
  Future<bool> get isOptimisticMarkedAllRead;
  Future setIsOptimisticMarkedAllRead();
  Future deleteIsOptimisticMarkedAllRead();

  Future<List<String>?> readOptimisticMarkedReadIds();
  Future setOptimisticMarkedReadId(String id);
  Future deleteOptimisticMarkedReadId(String id);
}

class StorageRepository implements OptimisticRepositoryInterface {
  final Storage<bool> _prefStorageSingle;
  final StorageList _prefStorageMultiple;

  StorageRepository(this._prefStorageSingle, this._prefStorageMultiple);

  @override
  Future<bool> get isOptimisticMarkedAllRead async => await _prefStorageSingle.hasValue(StorageKey.isOptimisticMarkedAllRead);

  @override
  Future<void> setIsOptimisticMarkedAllRead() async => await _prefStorageSingle.write(StorageKey.isOptimisticMarkedAllRead, true);

  @override
  Future<void> deleteIsOptimisticMarkedAllRead() async => await _prefStorageSingle.delete(StorageKey.isOptimisticMarkedAllRead);


  @override
  Future<void> setOptimisticMarkedReadId(String id) async => await _prefStorageMultiple.writeOne(StorageKey.optimisticMarkedReadIds, id);

  @override
  Future<void> deleteOptimisticMarkedReadId(String id) async => await _prefStorageMultiple.deleteOne(StorageKey.optimisticMarkedReadIds, id);

  @override
  Future<List<String>?> readOptimisticMarkedReadIds() async => await _prefStorageMultiple.read(StorageKey.optimisticMarkedReadIds);
}
