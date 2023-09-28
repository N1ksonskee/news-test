import 'package:flutter/material.dart';
import 'package:test_app/repositories/newsRepository.dart';
import 'package:test_app/repositories/storage_repository.dart';
import 'package:test_app/services/api/api.dart';
import 'package:test_app/services/storage/storage.dart';
import "app.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final storageRepository = StorageRepository(PrefStorageSingle(), PrefStorageList());
  final apiService = ApiService(storageRepository);
  runApp(TestApp(
    newsRepository: NewsRepository(apiService),
  ));
}
