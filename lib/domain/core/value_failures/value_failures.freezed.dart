// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'value_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ValueFailureTearOff {
  const _$ValueFailureTearOff();

  _Core<T> core<T>(CoreValueFaliue<T> coreFailure) {
    return _Core<T>(
      coreFailure,
    );
  }

  _Auth<T> auth<T>(AuthValueFailure<T> authFailure) {
    return _Auth<T>(
      authFailure,
    );
  }

  _Notes<T> notes<T>(NotesValueFailure<T> notesFailure) {
    return _Notes<T>(
      notesFailure,
    );
  }
}

/// @nodoc
const $ValueFailure = _$ValueFailureTearOff();

/// @nodoc
mixin _$ValueFailure<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CoreValueFaliue<T> coreFailure) core,
    required TResult Function(AuthValueFailure<T> authFailure) auth,
    required TResult Function(NotesValueFailure<T> notesFailure) notes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Core<T> value) core,
    required TResult Function(_Auth<T> value) auth,
    required TResult Function(_Notes<T> value) notes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueFailureCopyWith<T, $Res> {
  factory $ValueFailureCopyWith(
          ValueFailure<T> value, $Res Function(ValueFailure<T>) then) =
      _$ValueFailureCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ValueFailureCopyWithImpl<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  final ValueFailure<T> _value;
  // ignore: unused_field
  final $Res Function(ValueFailure<T>) _then;
}

/// @nodoc
abstract class _$CoreCopyWith<T, $Res> {
  factory _$CoreCopyWith(_Core<T> value, $Res Function(_Core<T>) then) =
      __$CoreCopyWithImpl<T, $Res>;
  $Res call({CoreValueFaliue<T> coreFailure});

  $CoreValueFaliueCopyWith<T, $Res> get coreFailure;
}

/// @nodoc
class __$CoreCopyWithImpl<T, $Res> extends _$ValueFailureCopyWithImpl<T, $Res>
    implements _$CoreCopyWith<T, $Res> {
  __$CoreCopyWithImpl(_Core<T> _value, $Res Function(_Core<T>) _then)
      : super(_value, (v) => _then(v as _Core<T>));

  @override
  _Core<T> get _value => super._value as _Core<T>;

  @override
  $Res call({
    Object? coreFailure = freezed,
  }) {
    return _then(_Core<T>(
      coreFailure == freezed
          ? _value.coreFailure
          : coreFailure // ignore: cast_nullable_to_non_nullable
              as CoreValueFaliue<T>,
    ));
  }

  @override
  $CoreValueFaliueCopyWith<T, $Res> get coreFailure {
    return $CoreValueFaliueCopyWith<T, $Res>(_value.coreFailure, (value) {
      return _then(_value.copyWith(coreFailure: value));
    });
  }
}

/// @nodoc

class _$_Core<T> implements _Core<T> {
  const _$_Core(this.coreFailure);

  @override
  final CoreValueFaliue<T> coreFailure;

  @override
  String toString() {
    return 'ValueFailure<$T>.core(coreFailure: $coreFailure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Core<T> &&
            const DeepCollectionEquality()
                .equals(other.coreFailure, coreFailure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(coreFailure));

  @JsonKey(ignore: true)
  @override
  _$CoreCopyWith<T, _Core<T>> get copyWith =>
      __$CoreCopyWithImpl<T, _Core<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CoreValueFaliue<T> coreFailure) core,
    required TResult Function(AuthValueFailure<T> authFailure) auth,
    required TResult Function(NotesValueFailure<T> notesFailure) notes,
  }) {
    return core(coreFailure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
  }) {
    return core?.call(coreFailure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
    required TResult orElse(),
  }) {
    if (core != null) {
      return core(coreFailure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Core<T> value) core,
    required TResult Function(_Auth<T> value) auth,
    required TResult Function(_Notes<T> value) notes,
  }) {
    return core(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
  }) {
    return core?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
    required TResult orElse(),
  }) {
    if (core != null) {
      return core(this);
    }
    return orElse();
  }
}

abstract class _Core<T> implements ValueFailure<T> {
  const factory _Core(CoreValueFaliue<T> coreFailure) = _$_Core<T>;

  CoreValueFaliue<T> get coreFailure;
  @JsonKey(ignore: true)
  _$CoreCopyWith<T, _Core<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthCopyWith<T, $Res> {
  factory _$AuthCopyWith(_Auth<T> value, $Res Function(_Auth<T>) then) =
      __$AuthCopyWithImpl<T, $Res>;
  $Res call({AuthValueFailure<T> authFailure});

  $AuthValueFailureCopyWith<T, $Res> get authFailure;
}

/// @nodoc
class __$AuthCopyWithImpl<T, $Res> extends _$ValueFailureCopyWithImpl<T, $Res>
    implements _$AuthCopyWith<T, $Res> {
  __$AuthCopyWithImpl(_Auth<T> _value, $Res Function(_Auth<T>) _then)
      : super(_value, (v) => _then(v as _Auth<T>));

  @override
  _Auth<T> get _value => super._value as _Auth<T>;

  @override
  $Res call({
    Object? authFailure = freezed,
  }) {
    return _then(_Auth<T>(
      authFailure == freezed
          ? _value.authFailure
          : authFailure // ignore: cast_nullable_to_non_nullable
              as AuthValueFailure<T>,
    ));
  }

  @override
  $AuthValueFailureCopyWith<T, $Res> get authFailure {
    return $AuthValueFailureCopyWith<T, $Res>(_value.authFailure, (value) {
      return _then(_value.copyWith(authFailure: value));
    });
  }
}

/// @nodoc

class _$_Auth<T> implements _Auth<T> {
  const _$_Auth(this.authFailure);

  @override
  final AuthValueFailure<T> authFailure;

  @override
  String toString() {
    return 'ValueFailure<$T>.auth(authFailure: $authFailure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Auth<T> &&
            const DeepCollectionEquality()
                .equals(other.authFailure, authFailure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(authFailure));

  @JsonKey(ignore: true)
  @override
  _$AuthCopyWith<T, _Auth<T>> get copyWith =>
      __$AuthCopyWithImpl<T, _Auth<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CoreValueFaliue<T> coreFailure) core,
    required TResult Function(AuthValueFailure<T> authFailure) auth,
    required TResult Function(NotesValueFailure<T> notesFailure) notes,
  }) {
    return auth(authFailure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
  }) {
    return auth?.call(authFailure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(authFailure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Core<T> value) core,
    required TResult Function(_Auth<T> value) auth,
    required TResult Function(_Notes<T> value) notes,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class _Auth<T> implements ValueFailure<T> {
  const factory _Auth(AuthValueFailure<T> authFailure) = _$_Auth<T>;

  AuthValueFailure<T> get authFailure;
  @JsonKey(ignore: true)
  _$AuthCopyWith<T, _Auth<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$NotesCopyWith<T, $Res> {
  factory _$NotesCopyWith(_Notes<T> value, $Res Function(_Notes<T>) then) =
      __$NotesCopyWithImpl<T, $Res>;
  $Res call({NotesValueFailure<T> notesFailure});

  $NotesValueFailureCopyWith<T, $Res> get notesFailure;
}

/// @nodoc
class __$NotesCopyWithImpl<T, $Res> extends _$ValueFailureCopyWithImpl<T, $Res>
    implements _$NotesCopyWith<T, $Res> {
  __$NotesCopyWithImpl(_Notes<T> _value, $Res Function(_Notes<T>) _then)
      : super(_value, (v) => _then(v as _Notes<T>));

  @override
  _Notes<T> get _value => super._value as _Notes<T>;

  @override
  $Res call({
    Object? notesFailure = freezed,
  }) {
    return _then(_Notes<T>(
      notesFailure == freezed
          ? _value.notesFailure
          : notesFailure // ignore: cast_nullable_to_non_nullable
              as NotesValueFailure<T>,
    ));
  }

  @override
  $NotesValueFailureCopyWith<T, $Res> get notesFailure {
    return $NotesValueFailureCopyWith<T, $Res>(_value.notesFailure, (value) {
      return _then(_value.copyWith(notesFailure: value));
    });
  }
}

/// @nodoc

class _$_Notes<T> implements _Notes<T> {
  const _$_Notes(this.notesFailure);

  @override
  final NotesValueFailure<T> notesFailure;

  @override
  String toString() {
    return 'ValueFailure<$T>.notes(notesFailure: $notesFailure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Notes<T> &&
            const DeepCollectionEquality()
                .equals(other.notesFailure, notesFailure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(notesFailure));

  @JsonKey(ignore: true)
  @override
  _$NotesCopyWith<T, _Notes<T>> get copyWith =>
      __$NotesCopyWithImpl<T, _Notes<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CoreValueFaliue<T> coreFailure) core,
    required TResult Function(AuthValueFailure<T> authFailure) auth,
    required TResult Function(NotesValueFailure<T> notesFailure) notes,
  }) {
    return notes(notesFailure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
  }) {
    return notes?.call(notesFailure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CoreValueFaliue<T> coreFailure)? core,
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    TResult Function(NotesValueFailure<T> notesFailure)? notes,
    required TResult orElse(),
  }) {
    if (notes != null) {
      return notes(notesFailure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Core<T> value) core,
    required TResult Function(_Auth<T> value) auth,
    required TResult Function(_Notes<T> value) notes,
  }) {
    return notes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
  }) {
    return notes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Core<T> value)? core,
    TResult Function(_Auth<T> value)? auth,
    TResult Function(_Notes<T> value)? notes,
    required TResult orElse(),
  }) {
    if (notes != null) {
      return notes(this);
    }
    return orElse();
  }
}

abstract class _Notes<T> implements ValueFailure<T> {
  const factory _Notes(NotesValueFailure<T> notesFailure) = _$_Notes<T>;

  NotesValueFailure<T> get notesFailure;
  @JsonKey(ignore: true)
  _$NotesCopyWith<T, _Notes<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
