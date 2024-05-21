// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rest_api_network_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkRequestBody {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Map<String, dynamic> data) json,
    required TResult Function(String data) text,
    required TResult Function(Map<String, dynamic> data) formData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Map<String, dynamic> data)? json,
    TResult? Function(String data)? text,
    TResult? Function(Map<String, dynamic> data)? formData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Map<String, dynamic> data)? json,
    TResult Function(String data)? text,
    TResult Function(Map<String, dynamic> data)? formData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Json value) json,
    required TResult Function(Text value) text,
    required TResult Function(Form value) formData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Json value)? json,
    TResult? Function(Text value)? text,
    TResult? Function(Form value)? formData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Json value)? json,
    TResult Function(Text value)? text,
    TResult Function(Form value)? formData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkRequestBodyCopyWith<$Res> {
  factory $NetworkRequestBodyCopyWith(
          NetworkRequestBody value, $Res Function(NetworkRequestBody) then) =
      _$NetworkRequestBodyCopyWithImpl<$Res, NetworkRequestBody>;
}

/// @nodoc
class _$NetworkRequestBodyCopyWithImpl<$Res, $Val extends NetworkRequestBody>
    implements $NetworkRequestBodyCopyWith<$Res> {
  _$NetworkRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EmptyImplCopyWith<$Res> {
  factory _$$EmptyImplCopyWith(
          _$EmptyImpl value, $Res Function(_$EmptyImpl) then) =
      __$$EmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyImplCopyWithImpl<$Res>
    extends _$NetworkRequestBodyCopyWithImpl<$Res, _$EmptyImpl>
    implements _$$EmptyImplCopyWith<$Res> {
  __$$EmptyImplCopyWithImpl(
      _$EmptyImpl _value, $Res Function(_$EmptyImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EmptyImpl with DiagnosticableTreeMixin implements Empty {
  const _$EmptyImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkRequestBody.empty()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'NetworkRequestBody.empty'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Map<String, dynamic> data) json,
    required TResult Function(String data) text,
    required TResult Function(Map<String, dynamic> data) formData,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Map<String, dynamic> data)? json,
    TResult? Function(String data)? text,
    TResult? Function(Map<String, dynamic> data)? formData,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Map<String, dynamic> data)? json,
    TResult Function(String data)? text,
    TResult Function(Map<String, dynamic> data)? formData,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Json value) json,
    required TResult Function(Text value) text,
    required TResult Function(Form value) formData,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Json value)? json,
    TResult? Function(Text value)? text,
    TResult? Function(Form value)? formData,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Json value)? json,
    TResult Function(Text value)? text,
    TResult Function(Form value)? formData,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class Empty implements NetworkRequestBody {
  const factory Empty() = _$EmptyImpl;
}

/// @nodoc
abstract class _$$JsonImplCopyWith<$Res> {
  factory _$$JsonImplCopyWith(
          _$JsonImpl value, $Res Function(_$JsonImpl) then) =
      __$$JsonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$JsonImplCopyWithImpl<$Res>
    extends _$NetworkRequestBodyCopyWithImpl<$Res, _$JsonImpl>
    implements _$$JsonImplCopyWith<$Res> {
  __$$JsonImplCopyWithImpl(_$JsonImpl _value, $Res Function(_$JsonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$JsonImpl(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$JsonImpl with DiagnosticableTreeMixin implements Json {
  const _$JsonImpl(final Map<String, dynamic> data) : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkRequestBody.json(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkRequestBody.json'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonImplCopyWith<_$JsonImpl> get copyWith =>
      __$$JsonImplCopyWithImpl<_$JsonImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Map<String, dynamic> data) json,
    required TResult Function(String data) text,
    required TResult Function(Map<String, dynamic> data) formData,
  }) {
    return json(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Map<String, dynamic> data)? json,
    TResult? Function(String data)? text,
    TResult? Function(Map<String, dynamic> data)? formData,
  }) {
    return json?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Map<String, dynamic> data)? json,
    TResult Function(String data)? text,
    TResult Function(Map<String, dynamic> data)? formData,
    required TResult orElse(),
  }) {
    if (json != null) {
      return json(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Json value) json,
    required TResult Function(Text value) text,
    required TResult Function(Form value) formData,
  }) {
    return json(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Json value)? json,
    TResult? Function(Text value)? text,
    TResult? Function(Form value)? formData,
  }) {
    return json?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Json value)? json,
    TResult Function(Text value)? text,
    TResult Function(Form value)? formData,
    required TResult orElse(),
  }) {
    if (json != null) {
      return json(this);
    }
    return orElse();
  }
}

abstract class Json implements NetworkRequestBody {
  const factory Json(final Map<String, dynamic> data) = _$JsonImpl;

  Map<String, dynamic> get data;
  @JsonKey(ignore: true)
  _$$JsonImplCopyWith<_$JsonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextImplCopyWith<$Res> {
  factory _$$TextImplCopyWith(
          _$TextImpl value, $Res Function(_$TextImpl) then) =
      __$$TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String data});
}

/// @nodoc
class __$$TextImplCopyWithImpl<$Res>
    extends _$NetworkRequestBodyCopyWithImpl<$Res, _$TextImpl>
    implements _$$TextImplCopyWith<$Res> {
  __$$TextImplCopyWithImpl(_$TextImpl _value, $Res Function(_$TextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$TextImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TextImpl with DiagnosticableTreeMixin implements Text {
  const _$TextImpl(this.data);

  @override
  final String data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkRequestBody.text(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkRequestBody.text'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextImplCopyWith<_$TextImpl> get copyWith =>
      __$$TextImplCopyWithImpl<_$TextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Map<String, dynamic> data) json,
    required TResult Function(String data) text,
    required TResult Function(Map<String, dynamic> data) formData,
  }) {
    return text(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Map<String, dynamic> data)? json,
    TResult? Function(String data)? text,
    TResult? Function(Map<String, dynamic> data)? formData,
  }) {
    return text?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Map<String, dynamic> data)? json,
    TResult Function(String data)? text,
    TResult Function(Map<String, dynamic> data)? formData,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Json value) json,
    required TResult Function(Text value) text,
    required TResult Function(Form value) formData,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Json value)? json,
    TResult? Function(Text value)? text,
    TResult? Function(Form value)? formData,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Json value)? json,
    TResult Function(Text value)? text,
    TResult Function(Form value)? formData,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class Text implements NetworkRequestBody {
  const factory Text(final String data) = _$TextImpl;

  String get data;
  @JsonKey(ignore: true)
  _$$TextImplCopyWith<_$TextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FormImplCopyWith<$Res> {
  factory _$$FormImplCopyWith(
          _$FormImpl value, $Res Function(_$FormImpl) then) =
      __$$FormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$FormImplCopyWithImpl<$Res>
    extends _$NetworkRequestBodyCopyWithImpl<$Res, _$FormImpl>
    implements _$$FormImplCopyWith<$Res> {
  __$$FormImplCopyWithImpl(_$FormImpl _value, $Res Function(_$FormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$FormImpl(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$FormImpl with DiagnosticableTreeMixin implements Form {
  const _$FormImpl(final Map<String, dynamic> data) : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkRequestBody.formData(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkRequestBody.formData'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FormImplCopyWith<_$FormImpl> get copyWith =>
      __$$FormImplCopyWithImpl<_$FormImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Map<String, dynamic> data) json,
    required TResult Function(String data) text,
    required TResult Function(Map<String, dynamic> data) formData,
  }) {
    return formData(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Map<String, dynamic> data)? json,
    TResult? Function(String data)? text,
    TResult? Function(Map<String, dynamic> data)? formData,
  }) {
    return formData?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Map<String, dynamic> data)? json,
    TResult Function(String data)? text,
    TResult Function(Map<String, dynamic> data)? formData,
    required TResult orElse(),
  }) {
    if (formData != null) {
      return formData(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Json value) json,
    required TResult Function(Text value) text,
    required TResult Function(Form value) formData,
  }) {
    return formData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Json value)? json,
    TResult? Function(Text value)? text,
    TResult? Function(Form value)? formData,
  }) {
    return formData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Json value)? json,
    TResult Function(Text value)? text,
    TResult Function(Form value)? formData,
    required TResult orElse(),
  }) {
    if (formData != null) {
      return formData(this);
    }
    return orElse();
  }
}

abstract class Form implements NetworkRequestBody {
  const factory Form(final Map<String, dynamic> data) = _$FormImpl;

  Map<String, dynamic> get data;
  @JsonKey(ignore: true)
  _$$FormImplCopyWith<_$FormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NetworkResponse<Model> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkResponseCopyWith<Model, $Res> {
  factory $NetworkResponseCopyWith(NetworkResponse<Model> value,
          $Res Function(NetworkResponse<Model>) then) =
      _$NetworkResponseCopyWithImpl<Model, $Res, NetworkResponse<Model>>;
}

/// @nodoc
class _$NetworkResponseCopyWithImpl<Model, $Res,
        $Val extends NetworkResponse<Model>>
    implements $NetworkResponseCopyWith<Model, $Res> {
  _$NetworkResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OkImplCopyWith<Model, $Res> {
  factory _$$OkImplCopyWith(
          _$OkImpl<Model> value, $Res Function(_$OkImpl<Model>) then) =
      __$$OkImplCopyWithImpl<Model, $Res>;
  @useResult
  $Res call({Model data});
}

/// @nodoc
class __$$OkImplCopyWithImpl<Model, $Res>
    extends _$NetworkResponseCopyWithImpl<Model, $Res, _$OkImpl<Model>>
    implements _$$OkImplCopyWith<Model, $Res> {
  __$$OkImplCopyWithImpl(
      _$OkImpl<Model> _value, $Res Function(_$OkImpl<Model>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$OkImpl<Model>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }
}

/// @nodoc

class _$OkImpl<Model> with DiagnosticableTreeMixin implements Ok<Model> {
  const _$OkImpl(this.data);

  @override
  final Model data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkResponse<$Model>.ok(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkResponse<$Model>.ok'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OkImpl<Model> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OkImplCopyWith<Model, _$OkImpl<Model>> get copyWith =>
      __$$OkImplCopyWithImpl<Model, _$OkImpl<Model>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) {
    return ok(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) {
    return ok?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) {
    if (ok != null) {
      return ok(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) {
    return ok(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) {
    return ok?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) {
    if (ok != null) {
      return ok(this);
    }
    return orElse();
  }
}

abstract class Ok<Model> implements NetworkResponse<Model> {
  const factory Ok(final Model data) = _$OkImpl<Model>;

  Model get data;
  @JsonKey(ignore: true)
  _$$OkImplCopyWith<Model, _$OkImpl<Model>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoDataImplCopyWith<Model, $Res> {
  factory _$$NoDataImplCopyWith(
          _$NoDataImpl<Model> value, $Res Function(_$NoDataImpl<Model>) then) =
      __$$NoDataImplCopyWithImpl<Model, $Res>;
  @useResult
  $Res call({ErrorValue message});
}

/// @nodoc
class __$$NoDataImplCopyWithImpl<Model, $Res>
    extends _$NetworkResponseCopyWithImpl<Model, $Res, _$NoDataImpl<Model>>
    implements _$$NoDataImplCopyWith<Model, $Res> {
  __$$NoDataImplCopyWithImpl(
      _$NoDataImpl<Model> _value, $Res Function(_$NoDataImpl<Model>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NoDataImpl<Model>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ErrorValue,
    ));
  }
}

/// @nodoc

class _$NoDataImpl<Model>
    with DiagnosticableTreeMixin
    implements NoData<Model> {
  const _$NoDataImpl(this.message);

  @override
  final ErrorValue message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkResponse<$Model>.noData(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkResponse<$Model>.noData'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoDataImpl<Model> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoDataImplCopyWith<Model, _$NoDataImpl<Model>> get copyWith =>
      __$$NoDataImplCopyWithImpl<Model, _$NoDataImpl<Model>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) {
    return noData(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) {
    return noData?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) {
    return noData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) {
    return noData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(this);
    }
    return orElse();
  }
}

abstract class NoData<Model> implements NetworkResponse<Model> {
  const factory NoData(final ErrorValue message) = _$NoDataImpl<Model>;

  ErrorValue get message;
  @JsonKey(ignore: true)
  _$$NoDataImplCopyWith<Model, _$NoDataImpl<Model>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomImplCopyWith<Model, $Res> {
  factory _$$CustomImplCopyWith(
          _$CustomImpl<Model> value, $Res Function(_$CustomImpl<Model>) then) =
      __$$CustomImplCopyWithImpl<Model, $Res>;
  @useResult
  $Res call({ErrorValue message});
}

/// @nodoc
class __$$CustomImplCopyWithImpl<Model, $Res>
    extends _$NetworkResponseCopyWithImpl<Model, $Res, _$CustomImpl<Model>>
    implements _$$CustomImplCopyWith<Model, $Res> {
  __$$CustomImplCopyWithImpl(
      _$CustomImpl<Model> _value, $Res Function(_$CustomImpl<Model>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CustomImpl<Model>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ErrorValue,
    ));
  }
}

/// @nodoc

class _$CustomImpl<Model>
    with DiagnosticableTreeMixin
    implements Custom<Model> {
  const _$CustomImpl(this.message);

  @override
  final ErrorValue message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkResponse<$Model>.custom(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkResponse<$Model>.custom'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomImpl<Model> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomImplCopyWith<Model, _$CustomImpl<Model>> get copyWith =>
      __$$CustomImplCopyWithImpl<Model, _$CustomImpl<Model>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) {
    return custom(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) {
    return custom?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) {
    return custom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) {
    return custom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(this);
    }
    return orElse();
  }
}

abstract class Custom<Model> implements NetworkResponse<Model> {
  const factory Custom(final ErrorValue message) = _$CustomImpl<Model>;

  ErrorValue get message;
  @JsonKey(ignore: true)
  _$$CustomImplCopyWith<Model, _$CustomImpl<Model>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTokenImplCopyWith<Model, $Res> {
  factory _$$UpdateTokenImplCopyWith(_$UpdateTokenImpl<Model> value,
          $Res Function(_$UpdateTokenImpl<Model>) then) =
      __$$UpdateTokenImplCopyWithImpl<Model, $Res>;
  @useResult
  $Res call({TokenModel? token, Model data});
}

/// @nodoc
class __$$UpdateTokenImplCopyWithImpl<Model, $Res>
    extends _$NetworkResponseCopyWithImpl<Model, $Res, _$UpdateTokenImpl<Model>>
    implements _$$UpdateTokenImplCopyWith<Model, $Res> {
  __$$UpdateTokenImplCopyWithImpl(_$UpdateTokenImpl<Model> _value,
      $Res Function(_$UpdateTokenImpl<Model>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? data = freezed,
  }) {
    return _then(_$UpdateTokenImpl<Model>(
      freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenModel?,
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }
}

/// @nodoc

class _$UpdateTokenImpl<Model>
    with DiagnosticableTreeMixin
    implements UpdateToken<Model> {
  const _$UpdateTokenImpl(this.token, this.data);

  @override
  final TokenModel? token;
  @override
  final Model data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkResponse<$Model>.updateToken(token: $token, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkResponse<$Model>.updateToken'))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTokenImpl<Model> &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, token, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTokenImplCopyWith<Model, _$UpdateTokenImpl<Model>> get copyWith =>
      __$$UpdateTokenImplCopyWithImpl<Model, _$UpdateTokenImpl<Model>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) {
    return updateToken(token, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) {
    return updateToken?.call(token, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) {
    if (updateToken != null) {
      return updateToken(token, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) {
    return updateToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) {
    return updateToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) {
    if (updateToken != null) {
      return updateToken(this);
    }
    return orElse();
  }
}

abstract class UpdateToken<Model> implements NetworkResponse<Model> {
  const factory UpdateToken(final TokenModel? token, final Model data) =
      _$UpdateTokenImpl<Model>;

  TokenModel? get token;
  Model get data;
  @JsonKey(ignore: true)
  _$$UpdateTokenImplCopyWith<Model, _$UpdateTokenImpl<Model>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTokenErrorImplCopyWith<Model, $Res> {
  factory _$$UpdateTokenErrorImplCopyWith(_$UpdateTokenErrorImpl<Model> value,
          $Res Function(_$UpdateTokenErrorImpl<Model>) then) =
      __$$UpdateTokenErrorImplCopyWithImpl<Model, $Res>;
  @useResult
  $Res call({ErrorValue? error, TokenModel? token});
}

/// @nodoc
class __$$UpdateTokenErrorImplCopyWithImpl<Model, $Res>
    extends _$NetworkResponseCopyWithImpl<Model, $Res,
        _$UpdateTokenErrorImpl<Model>>
    implements _$$UpdateTokenErrorImplCopyWith<Model, $Res> {
  __$$UpdateTokenErrorImplCopyWithImpl(_$UpdateTokenErrorImpl<Model> _value,
      $Res Function(_$UpdateTokenErrorImpl<Model>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? token = freezed,
  }) {
    return _then(_$UpdateTokenErrorImpl<Model>(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorValue?,
      freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenModel?,
    ));
  }
}

/// @nodoc

class _$UpdateTokenErrorImpl<Model>
    with DiagnosticableTreeMixin
    implements UpdateTokenError<Model> {
  const _$UpdateTokenErrorImpl(this.error, this.token);

  @override
  final ErrorValue? error;
  @override
  final TokenModel? token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkResponse<$Model>.updateTokenError(error: $error, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'NetworkResponse<$Model>.updateTokenError'))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTokenErrorImpl<Model> &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTokenErrorImplCopyWith<Model, _$UpdateTokenErrorImpl<Model>>
      get copyWith => __$$UpdateTokenErrorImplCopyWithImpl<Model,
          _$UpdateTokenErrorImpl<Model>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) {
    return updateTokenError(error, token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) {
    return updateTokenError?.call(error, token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) {
    if (updateTokenError != null) {
      return updateTokenError(error, token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) {
    return updateTokenError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) {
    return updateTokenError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) {
    if (updateTokenError != null) {
      return updateTokenError(this);
    }
    return orElse();
  }
}

abstract class UpdateTokenError<Model> implements NetworkResponse<Model> {
  const factory UpdateTokenError(
          final ErrorValue? error, final TokenModel? token) =
      _$UpdateTokenErrorImpl<Model>;

  ErrorValue? get error;
  TokenModel? get token;
  @JsonKey(ignore: true)
  _$$UpdateTokenErrorImplCopyWith<Model, _$UpdateTokenErrorImpl<Model>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutImplCopyWith<Model, $Res> {
  factory _$$LogoutImplCopyWith(
          _$LogoutImpl<Model> value, $Res Function(_$LogoutImpl<Model>) then) =
      __$$LogoutImplCopyWithImpl<Model, $Res>;
  @useResult
  $Res call({TokenModel? old});
}

/// @nodoc
class __$$LogoutImplCopyWithImpl<Model, $Res>
    extends _$NetworkResponseCopyWithImpl<Model, $Res, _$LogoutImpl<Model>>
    implements _$$LogoutImplCopyWith<Model, $Res> {
  __$$LogoutImplCopyWithImpl(
      _$LogoutImpl<Model> _value, $Res Function(_$LogoutImpl<Model>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? old = freezed,
  }) {
    return _then(_$LogoutImpl<Model>(
      freezed == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as TokenModel?,
    ));
  }
}

/// @nodoc

class _$LogoutImpl<Model>
    with DiagnosticableTreeMixin
    implements Logout<Model> {
  const _$LogoutImpl(this.old);

  @override
  final TokenModel? old;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkResponse<$Model>.logout(old: $old)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkResponse<$Model>.logout'))
      ..add(DiagnosticsProperty('old', old));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutImpl<Model> &&
            (identical(other.old, old) || other.old == old));
  }

  @override
  int get hashCode => Object.hash(runtimeType, old);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogoutImplCopyWith<Model, _$LogoutImpl<Model>> get copyWith =>
      __$$LogoutImplCopyWithImpl<Model, _$LogoutImpl<Model>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Model data) ok,
    required TResult Function(ErrorValue message) noData,
    required TResult Function(ErrorValue message) custom,
    required TResult Function(TokenModel? token, Model data) updateToken,
    required TResult Function(ErrorValue? error, TokenModel? token)
        updateTokenError,
    required TResult Function(TokenModel? old) logout,
  }) {
    return logout(old);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Model data)? ok,
    TResult? Function(ErrorValue message)? noData,
    TResult? Function(ErrorValue message)? custom,
    TResult? Function(TokenModel? token, Model data)? updateToken,
    TResult? Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult? Function(TokenModel? old)? logout,
  }) {
    return logout?.call(old);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Model data)? ok,
    TResult Function(ErrorValue message)? noData,
    TResult Function(ErrorValue message)? custom,
    TResult Function(TokenModel? token, Model data)? updateToken,
    TResult Function(ErrorValue? error, TokenModel? token)? updateTokenError,
    TResult Function(TokenModel? old)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(old);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok<Model> value) ok,
    required TResult Function(NoData<Model> value) noData,
    required TResult Function(Custom<Model> value) custom,
    required TResult Function(UpdateToken<Model> value) updateToken,
    required TResult Function(UpdateTokenError<Model> value) updateTokenError,
    required TResult Function(Logout<Model> value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok<Model> value)? ok,
    TResult? Function(NoData<Model> value)? noData,
    TResult? Function(Custom<Model> value)? custom,
    TResult? Function(UpdateToken<Model> value)? updateToken,
    TResult? Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult? Function(Logout<Model> value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok<Model> value)? ok,
    TResult Function(NoData<Model> value)? noData,
    TResult Function(Custom<Model> value)? custom,
    TResult Function(UpdateToken<Model> value)? updateToken,
    TResult Function(UpdateTokenError<Model> value)? updateTokenError,
    TResult Function(Logout<Model> value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class Logout<Model> implements NetworkResponse<Model> {
  const factory Logout(final TokenModel? old) = _$LogoutImpl<Model>;

  TokenModel? get old;
  @JsonKey(ignore: true)
  _$$LogoutImplCopyWith<Model, _$LogoutImpl<Model>> get copyWith =>
      throw _privateConstructorUsedError;
}
