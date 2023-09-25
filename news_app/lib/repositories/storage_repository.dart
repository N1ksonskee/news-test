import 'package:test_app/services/storage/storage.dart';

enum StorageKey { isOptimisticMarkedAllRead, optimisticMarkedReadIds }

abstract class OptimisticRepositoryInterface {
  Future<bool> get isOptimisticMarkedAllRead;
  Future setIsOptimisticMarkedAllRead();
  Future deleteIsOptimisticMarkedAllRead();

  Future<List<String>?> readOptimisticMarkedReadIds();
  Future setOptimisticMarkedReadId(String id);
  Future deleteOptimisticMarkedReadId(String id);
  Future<bool> hasOptimisticMarkedReadId(String id);
}

class StorageRepository implements OptimisticRepositoryInterface {
  final Storage<bool> _optimisticSingleStorage;
  final StorageList _optimisticListStorage;

  StorageRepository(Storage<bool> optimisticSingleStorage, StorageList optimisticListStorage)
      : _optimisticSingleStorage = optimisticSingleStorage,
        _optimisticListStorage = optimisticListStorage;

  @override
  Future<bool> get isOptimisticMarkedAllRead async => await _optimisticSingleStorage.hasValue(StorageKey.isOptimisticMarkedAllRead);

  @override
  Future<void> setIsOptimisticMarkedAllRead() async => await _optimisticSingleStorage.write(StorageKey.isOptimisticMarkedAllRead, true);

  @override
  Future<void> deleteIsOptimisticMarkedAllRead() async => await _optimisticSingleStorage.delete(StorageKey.isOptimisticMarkedAllRead);

  @override
  Future<void> setOptimisticMarkedReadId(String id) async => await _optimisticListStorage.writeOne(StorageKey.optimisticMarkedReadIds, id);

  @override
  Future<void> deleteOptimisticMarkedReadId(String id) async => await _optimisticListStorage.deleteOne(StorageKey.optimisticMarkedReadIds, id);

  @override
  Future<bool> hasOptimisticMarkedReadId(String id) async => await _optimisticListStorage.hasOne(StorageKey.optimisticMarkedReadIds, id);

  @override
  Future<List<String>?> readOptimisticMarkedReadIds() async => await _optimisticListStorage.read(StorageKey.optimisticMarkedReadIds);
}
