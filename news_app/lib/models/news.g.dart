// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<News> _$newsSerializer = new _$NewsSerializer();

class _$NewsSerializer implements StructuredSerializer<News> {
  @override
  final Iterable<Type> types = const [News, _$News];
  @override
  final String wireName = 'News';

  @override
  Iterable<Object?> serialize(Serializers serializers, News object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'isRead',
      serializers.serialize(object.isRead, specifiedType: const FullType(bool)),
      'imageUrl',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  News deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isRead':
          result.isRead = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$News extends News {
  @override
  final int id;
  @override
  final String title;
  @override
  final BuiltList<String> content;
  @override
  final String createdAt;
  @override
  final bool isRead;
  @override
  final String imageUrl;

  factory _$News([void Function(NewsBuilder)? updates]) =>
      (new NewsBuilder()..update(updates))._build();

  _$News._(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.isRead,
      required this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'News', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'News', 'title');
    BuiltValueNullFieldError.checkNotNull(content, r'News', 'content');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'News', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(isRead, r'News', 'isRead');
    BuiltValueNullFieldError.checkNotNull(imageUrl, r'News', 'imageUrl');
  }

  @override
  News rebuild(void Function(NewsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsBuilder toBuilder() => new NewsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is News &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        createdAt == other.createdAt &&
        isRead == other.isRead &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'News')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('isRead', isRead)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class NewsBuilder implements Builder<News, NewsBuilder> {
  _$News? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<String>? _content;
  ListBuilder<String> get content =>
      _$this._content ??= new ListBuilder<String>();
  set content(ListBuilder<String>? content) => _$this._content = content;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  NewsBuilder();

  NewsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content.toBuilder();
      _createdAt = $v.createdAt;
      _isRead = $v.isRead;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(News other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$News;
  }

  @override
  void update(void Function(NewsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  News build() => _build();

  _$News _build() {
    _$News _$result;
    try {
      _$result = _$v ??
          new _$News._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'News', 'id'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'News', 'title'),
              content: content.build(),
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'News', 'createdAt'),
              isRead: BuiltValueNullFieldError.checkNotNull(
                  isRead, r'News', 'isRead'),
              imageUrl: BuiltValueNullFieldError.checkNotNull(
                  imageUrl, r'News', 'imageUrl'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'content';
        content.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'News', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
