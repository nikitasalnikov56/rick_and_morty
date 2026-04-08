// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CharacterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isRefresh, String? name, String? status, String? gender)
        fetchCharacters,
    required TResult Function(int id, void Function(String)? onComplete)
        toggleFavorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isRefresh, String? name, String? status, String? gender)?
        fetchCharacters,
    TResult? Function(int id, void Function(String)? onComplete)?
        toggleFavorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isRefresh, String? name, String? status, String? gender)?
        fetchCharacters,
    TResult Function(int id, void Function(String)? onComplete)? toggleFavorite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCharacters value) fetchCharacters,
    required TResult Function(ToggleFavorite value) toggleFavorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCharacters value)? fetchCharacters,
    TResult? Function(ToggleFavorite value)? toggleFavorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCharacters value)? fetchCharacters,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterEventCopyWith<$Res> {
  factory $CharacterEventCopyWith(
          CharacterEvent value, $Res Function(CharacterEvent) then) =
      _$CharacterEventCopyWithImpl<$Res, CharacterEvent>;
}

/// @nodoc
class _$CharacterEventCopyWithImpl<$Res, $Val extends CharacterEvent>
    implements $CharacterEventCopyWith<$Res> {
  _$CharacterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchCharactersImplCopyWith<$Res> {
  factory _$$FetchCharactersImplCopyWith(_$FetchCharactersImpl value,
          $Res Function(_$FetchCharactersImpl) then) =
      __$$FetchCharactersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isRefresh, String? name, String? status, String? gender});
}

/// @nodoc
class __$$FetchCharactersImplCopyWithImpl<$Res>
    extends _$CharacterEventCopyWithImpl<$Res, _$FetchCharactersImpl>
    implements _$$FetchCharactersImplCopyWith<$Res> {
  __$$FetchCharactersImplCopyWithImpl(
      _$FetchCharactersImpl _value, $Res Function(_$FetchCharactersImpl) _then)
      : super(_value, _then);

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRefresh = null,
    Object? name = freezed,
    Object? status = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$FetchCharactersImpl(
      isRefresh: null == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FetchCharactersImpl implements FetchCharacters {
  const _$FetchCharactersImpl(
      {this.isRefresh = false, this.name, this.status, this.gender});

  @override
  @JsonKey()
  final bool isRefresh;
  @override
  final String? name;
  @override
  final String? status;
  @override
  final String? gender;

  @override
  String toString() {
    return 'CharacterEvent.fetchCharacters(isRefresh: $isRefresh, name: $name, status: $status, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCharactersImpl &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isRefresh, name, status, gender);

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCharactersImplCopyWith<_$FetchCharactersImpl> get copyWith =>
      __$$FetchCharactersImplCopyWithImpl<_$FetchCharactersImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isRefresh, String? name, String? status, String? gender)
        fetchCharacters,
    required TResult Function(int id, void Function(String)? onComplete)
        toggleFavorite,
  }) {
    return fetchCharacters(isRefresh, name, status, gender);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isRefresh, String? name, String? status, String? gender)?
        fetchCharacters,
    TResult? Function(int id, void Function(String)? onComplete)?
        toggleFavorite,
  }) {
    return fetchCharacters?.call(isRefresh, name, status, gender);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isRefresh, String? name, String? status, String? gender)?
        fetchCharacters,
    TResult Function(int id, void Function(String)? onComplete)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (fetchCharacters != null) {
      return fetchCharacters(isRefresh, name, status, gender);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCharacters value) fetchCharacters,
    required TResult Function(ToggleFavorite value) toggleFavorite,
  }) {
    return fetchCharacters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCharacters value)? fetchCharacters,
    TResult? Function(ToggleFavorite value)? toggleFavorite,
  }) {
    return fetchCharacters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCharacters value)? fetchCharacters,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (fetchCharacters != null) {
      return fetchCharacters(this);
    }
    return orElse();
  }
}

abstract class FetchCharacters implements CharacterEvent {
  const factory FetchCharacters(
      {final bool isRefresh,
      final String? name,
      final String? status,
      final String? gender}) = _$FetchCharactersImpl;

  bool get isRefresh;
  String? get name;
  String? get status;
  String? get gender;

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchCharactersImplCopyWith<_$FetchCharactersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleFavoriteImplCopyWith<$Res> {
  factory _$$ToggleFavoriteImplCopyWith(_$ToggleFavoriteImpl value,
          $Res Function(_$ToggleFavoriteImpl) then) =
      __$$ToggleFavoriteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id, void Function(String)? onComplete});
}

/// @nodoc
class __$$ToggleFavoriteImplCopyWithImpl<$Res>
    extends _$CharacterEventCopyWithImpl<$Res, _$ToggleFavoriteImpl>
    implements _$$ToggleFavoriteImplCopyWith<$Res> {
  __$$ToggleFavoriteImplCopyWithImpl(
      _$ToggleFavoriteImpl _value, $Res Function(_$ToggleFavoriteImpl) _then)
      : super(_value, _then);

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? onComplete = freezed,
  }) {
    return _then(_$ToggleFavoriteImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      onComplete: freezed == onComplete
          ? _value.onComplete
          : onComplete // ignore: cast_nullable_to_non_nullable
              as void Function(String)?,
    ));
  }
}

/// @nodoc

class _$ToggleFavoriteImpl implements ToggleFavorite {
  const _$ToggleFavoriteImpl(this.id, {this.onComplete});

  @override
  final int id;
  @override
  final void Function(String)? onComplete;

  @override
  String toString() {
    return 'CharacterEvent.toggleFavorite(id: $id, onComplete: $onComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleFavoriteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.onComplete, onComplete) ||
                other.onComplete == onComplete));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, onComplete);

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      __$$ToggleFavoriteImplCopyWithImpl<_$ToggleFavoriteImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isRefresh, String? name, String? status, String? gender)
        fetchCharacters,
    required TResult Function(int id, void Function(String)? onComplete)
        toggleFavorite,
  }) {
    return toggleFavorite(id, onComplete);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isRefresh, String? name, String? status, String? gender)?
        fetchCharacters,
    TResult? Function(int id, void Function(String)? onComplete)?
        toggleFavorite,
  }) {
    return toggleFavorite?.call(id, onComplete);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isRefresh, String? name, String? status, String? gender)?
        fetchCharacters,
    TResult Function(int id, void Function(String)? onComplete)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(id, onComplete);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCharacters value) fetchCharacters,
    required TResult Function(ToggleFavorite value) toggleFavorite,
  }) {
    return toggleFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCharacters value)? fetchCharacters,
    TResult? Function(ToggleFavorite value)? toggleFavorite,
  }) {
    return toggleFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCharacters value)? fetchCharacters,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(this);
    }
    return orElse();
  }
}

abstract class ToggleFavorite implements CharacterEvent {
  const factory ToggleFavorite(final int id,
      {final void Function(String)? onComplete}) = _$ToggleFavoriteImpl;

  int get id;
  void Function(String)? get onComplete;

  /// Create a copy of CharacterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
