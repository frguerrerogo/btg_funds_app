// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fund_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FundEntity {

 String get id; String get name; double get minimumAmount; FundCategory get category; bool get isSubscribed;
/// Create a copy of FundEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FundEntityCopyWith<FundEntity> get copyWith => _$FundEntityCopyWithImpl<FundEntity>(this as FundEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FundEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.category, category) || other.category == category)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,minimumAmount,category,isSubscribed);

@override
String toString() {
  return 'FundEntity(id: $id, name: $name, minimumAmount: $minimumAmount, category: $category, isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class $FundEntityCopyWith<$Res>  {
  factory $FundEntityCopyWith(FundEntity value, $Res Function(FundEntity) _then) = _$FundEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, double minimumAmount, FundCategory category, bool isSubscribed
});




}
/// @nodoc
class _$FundEntityCopyWithImpl<$Res>
    implements $FundEntityCopyWith<$Res> {
  _$FundEntityCopyWithImpl(this._self, this._then);

  final FundEntity _self;
  final $Res Function(FundEntity) _then;

/// Create a copy of FundEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? minimumAmount = null,Object? category = null,Object? isSubscribed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minimumAmount: null == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as FundCategory,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FundEntity].
extension FundEntityPatterns on FundEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FundEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FundEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FundEntity value)  $default,){
final _that = this;
switch (_that) {
case _FundEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FundEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FundEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double minimumAmount,  FundCategory category,  bool isSubscribed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FundEntity() when $default != null:
return $default(_that.id,_that.name,_that.minimumAmount,_that.category,_that.isSubscribed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double minimumAmount,  FundCategory category,  bool isSubscribed)  $default,) {final _that = this;
switch (_that) {
case _FundEntity():
return $default(_that.id,_that.name,_that.minimumAmount,_that.category,_that.isSubscribed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double minimumAmount,  FundCategory category,  bool isSubscribed)?  $default,) {final _that = this;
switch (_that) {
case _FundEntity() when $default != null:
return $default(_that.id,_that.name,_that.minimumAmount,_that.category,_that.isSubscribed);case _:
  return null;

}
}

}

/// @nodoc


class _FundEntity extends FundEntity {
  const _FundEntity({required this.id, required this.name, required this.minimumAmount, required this.category, this.isSubscribed = false}): super._();
  

@override final  String id;
@override final  String name;
@override final  double minimumAmount;
@override final  FundCategory category;
@override@JsonKey() final  bool isSubscribed;

/// Create a copy of FundEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundEntityCopyWith<_FundEntity> get copyWith => __$FundEntityCopyWithImpl<_FundEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FundEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.category, category) || other.category == category)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,minimumAmount,category,isSubscribed);

@override
String toString() {
  return 'FundEntity(id: $id, name: $name, minimumAmount: $minimumAmount, category: $category, isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class _$FundEntityCopyWith<$Res> implements $FundEntityCopyWith<$Res> {
  factory _$FundEntityCopyWith(_FundEntity value, $Res Function(_FundEntity) _then) = __$FundEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double minimumAmount, FundCategory category, bool isSubscribed
});




}
/// @nodoc
class __$FundEntityCopyWithImpl<$Res>
    implements _$FundEntityCopyWith<$Res> {
  __$FundEntityCopyWithImpl(this._self, this._then);

  final _FundEntity _self;
  final $Res Function(_FundEntity) _then;

/// Create a copy of FundEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? minimumAmount = null,Object? category = null,Object? isSubscribed = null,}) {
  return _then(_FundEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minimumAmount: null == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as FundCategory,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
