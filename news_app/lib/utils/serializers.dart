import "package:built_value/serializer.dart";
import "package:built_value/standard_json_plugin.dart";
import 'package:built_collection/built_collection.dart';

import 'package:test_app/models/news.dart';

part 'serializers.g.dart';

@SerializersFor([News])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

T? deserialize<T>(dynamic data) {
  final serializer = serializers.serializerForType(T);

  if (serializer == null) return null;

  return serializers.deserializeWith(serializer as Serializer<T>, data);
}

BuiltList<T> deserializeListOf<T>(List<dynamic> data) => BuiltList.from(data.map((data) => deserialize<T>(data)).toList());
