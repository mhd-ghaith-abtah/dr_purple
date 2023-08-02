// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MediaObject {
  String get mediaPath => throw _privateConstructorUsedError;
  String get mediaTaskId => throw _privateConstructorUsedError;
  UploadState get uploadState => throw _privateConstructorUsedError;
  double? get progress => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaObjectCopyWith<MediaObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaObjectCopyWith<$Res> {
  factory $MediaObjectCopyWith(
          MediaObject value, $Res Function(MediaObject) then) =
      _$MediaObjectCopyWithImpl<$Res, MediaObject>;
  @useResult
  $Res call(
      {String mediaPath,
      String mediaTaskId,
      UploadState uploadState,
      double? progress,
      String id});
}

/// @nodoc
class _$MediaObjectCopyWithImpl<$Res, $Val extends MediaObject>
    implements $MediaObjectCopyWith<$Res> {
  _$MediaObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaPath = null,
    Object? mediaTaskId = null,
    Object? uploadState = null,
    Object? progress = freezed,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      mediaPath: null == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String,
      mediaTaskId: null == mediaTaskId
          ? _value.mediaTaskId
          : mediaTaskId // ignore: cast_nullable_to_non_nullable
              as String,
      uploadState: null == uploadState
          ? _value.uploadState
          : uploadState // ignore: cast_nullable_to_non_nullable
              as UploadState,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MediaObjectCopyWith<$Res>
    implements $MediaObjectCopyWith<$Res> {
  factory _$$_MediaObjectCopyWith(
          _$_MediaObject value, $Res Function(_$_MediaObject) then) =
      __$$_MediaObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mediaPath,
      String mediaTaskId,
      UploadState uploadState,
      double? progress,
      String id});
}

/// @nodoc
class __$$_MediaObjectCopyWithImpl<$Res>
    extends _$MediaObjectCopyWithImpl<$Res, _$_MediaObject>
    implements _$$_MediaObjectCopyWith<$Res> {
  __$$_MediaObjectCopyWithImpl(
      _$_MediaObject _value, $Res Function(_$_MediaObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaPath = null,
    Object? mediaTaskId = null,
    Object? uploadState = null,
    Object? progress = freezed,
    Object? id = null,
  }) {
    return _then(_$_MediaObject(
      null == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String,
      null == mediaTaskId
          ? _value.mediaTaskId
          : mediaTaskId // ignore: cast_nullable_to_non_nullable
              as String,
      null == uploadState
          ? _value.uploadState
          : uploadState // ignore: cast_nullable_to_non_nullable
              as UploadState,
      freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double?,
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MediaObject implements _MediaObject {
  _$_MediaObject(this.mediaPath, this.mediaTaskId, this.uploadState,
      this.progress, this.id);

  @override
  final String mediaPath;
  @override
  final String mediaTaskId;
  @override
  final UploadState uploadState;
  @override
  final double? progress;
  @override
  final String id;

  @override
  String toString() {
    return 'MediaObject(mediaPath: $mediaPath, mediaTaskId: $mediaTaskId, uploadState: $uploadState, progress: $progress, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaObject &&
            (identical(other.mediaPath, mediaPath) ||
                other.mediaPath == mediaPath) &&
            (identical(other.mediaTaskId, mediaTaskId) ||
                other.mediaTaskId == mediaTaskId) &&
            (identical(other.uploadState, uploadState) ||
                other.uploadState == uploadState) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, mediaPath, mediaTaskId, uploadState, progress, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaObjectCopyWith<_$_MediaObject> get copyWith =>
      __$$_MediaObjectCopyWithImpl<_$_MediaObject>(this, _$identity);
}

abstract class _MediaObject implements MediaObject {
  factory _MediaObject(
      final String mediaPath,
      final String mediaTaskId,
      final UploadState uploadState,
      final double? progress,
      final String id) = _$_MediaObject;

  @override
  String get mediaPath;
  @override
  String get mediaTaskId;
  @override
  UploadState get uploadState;
  @override
  double? get progress;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_MediaObjectCopyWith<_$_MediaObject> get copyWith =>
      throw _privateConstructorUsedError;
}
