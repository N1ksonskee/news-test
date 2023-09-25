import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'news.g.dart';

abstract class News implements Built<News, NewsBuilder> {
  News._();

  int get id;
  String get title;
  BuiltList<String> get content;
  String get createdAt;
  bool get isRead;
  String get imageUrl;

  factory News([Function(NewsBuilder b) updates]) = _$News;

  static Serializer<News> get serializer => _$newsSerializer;
}
