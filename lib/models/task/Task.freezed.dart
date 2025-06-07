// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;
  String get bucket => throw _privateConstructorUsedError;
  List<Song> get songs => throw _privateConstructorUsedError;
  @JsonKey(name: "created_by")
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: "created_on")
  int get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: "file_upload_path")
  String? get fileUploadPath => throw _privateConstructorUsedError;
  @JsonKey(name: "image_url")
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get file => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      TaskStatus status,
      String bucket,
      List<Song> songs,
      @JsonKey(name: "created_by") String createdBy,
      @JsonKey(name: "created_on") int createdOn,
      @JsonKey(name: "file_upload_path") String? fileUploadPath,
      @JsonKey(name: "image_url") String imageUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) File? file});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? bucket = null,
    Object? songs = null,
    Object? createdBy = null,
    Object? createdOn = null,
    Object? fileUploadPath = freezed,
    Object? imageUrl = null,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      bucket: null == bucket
          ? _value.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int,
      fileUploadPath: freezed == fileUploadPath
          ? _value.fileUploadPath
          : fileUploadPath // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      TaskStatus status,
      String bucket,
      List<Song> songs,
      @JsonKey(name: "created_by") String createdBy,
      @JsonKey(name: "created_on") int createdOn,
      @JsonKey(name: "file_upload_path") String? fileUploadPath,
      @JsonKey(name: "image_url") String imageUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) File? file});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? bucket = null,
    Object? songs = null,
    Object? createdBy = null,
    Object? createdOn = null,
    Object? fileUploadPath = freezed,
    Object? imageUrl = null,
    Object? file = freezed,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      bucket: null == bucket
          ? _value.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int,
      fileUploadPath: freezed == fileUploadPath
          ? _value.fileUploadPath
          : fileUploadPath // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl extends _Task {
  const _$TaskImpl(
      {required this.id,
      required this.status,
      required this.bucket,
      final List<Song> songs = const [],
      @JsonKey(name: "created_by") required this.createdBy,
      @JsonKey(name: "created_on") required this.createdOn,
      @JsonKey(name: "file_upload_path") this.fileUploadPath,
      @JsonKey(name: "image_url")
      this.imageUrl = "https://i.sstatic.net/y9DpT.jpg",
      @JsonKey(includeFromJson: false, includeToJson: false) this.file})
      : _songs = songs,
        super._();

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final TaskStatus status;
  @override
  final String bucket;
  final List<Song> _songs;
  @override
  @JsonKey()
  List<Song> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  @JsonKey(name: "created_by")
  final String createdBy;
  @override
  @JsonKey(name: "created_on")
  final int createdOn;
  @override
  @JsonKey(name: "file_upload_path")
  final String? fileUploadPath;
  @override
  @JsonKey(name: "image_url")
  final String imageUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? file;

  @override
  String toString() {
    return 'Task(id: $id, status: $status, bucket: $bucket, songs: $songs, createdBy: $createdBy, createdOn: $createdOn, fileUploadPath: $fileUploadPath, imageUrl: $imageUrl, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bucket, bucket) || other.bucket == bucket) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.fileUploadPath, fileUploadPath) ||
                other.fileUploadPath == fileUploadPath) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      bucket,
      const DeepCollectionEquality().hash(_songs),
      createdBy,
      createdOn,
      fileUploadPath,
      imageUrl,
      file);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task extends Task {
  const factory _Task(
      {required final String id,
      required final TaskStatus status,
      required final String bucket,
      final List<Song> songs,
      @JsonKey(name: "created_by") required final String createdBy,
      @JsonKey(name: "created_on") required final int createdOn,
      @JsonKey(name: "file_upload_path") final String? fileUploadPath,
      @JsonKey(name: "image_url") final String imageUrl,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final File? file}) = _$TaskImpl;
  const _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  TaskStatus get status;
  @override
  String get bucket;
  @override
  List<Song> get songs;
  @override
  @JsonKey(name: "created_by")
  String get createdBy;
  @override
  @JsonKey(name: "created_on")
  int get createdOn;
  @override
  @JsonKey(name: "file_upload_path")
  String? get fileUploadPath;
  @override
  @JsonKey(name: "image_url")
  String get imageUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get file;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
