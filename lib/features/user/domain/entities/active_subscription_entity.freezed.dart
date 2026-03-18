// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_subscription_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveSubscriptionEntity {

 String get fundId; String get fundName; double get amount; DateTime get subscribedAt;
/// Create a copy of ActiveSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveSubscriptionEntityCopyWith<ActiveSubscriptionEntity> get copyWith => _$ActiveSubscriptionEntityCopyWithImpl<ActiveSubscriptionEntity>(this as ActiveSubscriptionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSubscriptionEntity&&(identical(other.fundId, fundId) || other.fundId == fundId)&&(identical(other.fundName, fundName) || other.fundName == fundName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.subscribedAt, subscribedAt) || other.subscribedAt == subscribedAt));
}


@override
int get hashCode => Object.hash(runtimeType,fundId,fundName,amount,subscribedAt);

@override
String toString() {
  return 'ActiveSubscriptionEntity(fundId: $fundId, fundName: $fundName, amount: $amount, subscribedAt: $subscribedAt)';
}


}

/// @nodoc
abstract mixin class $ActiveSubscriptionEntityCopyWith<$Res>  {
  factory $ActiveSubscriptionEntityCopyWith(ActiveSubscriptionEntity value, $Res Function(ActiveSubscriptionEntity) _then) = _$ActiveSubscriptionEntityCopyWithImpl;
@useResult
$Res call({
 String fundId, String fundName, double amount, DateTime subscribedAt
});




}
/// @nodoc
class _$ActiveSubscriptionEntityCopyWithImpl<$Res>
    implements $ActiveSubscriptionEntityCopyWith<$Res> {
  _$ActiveSubscriptionEntityCopyWithImpl(this._self, this._then);

  final ActiveSubscriptionEntity _self;
  final $Res Function(ActiveSubscriptionEntity) _then;

/// Create a copy of ActiveSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fundId = null,Object? fundName = null,Object? amount = null,Object? subscribedAt = null,}) {
  return _then(_self.copyWith(
fundId: null == fundId ? _self.fundId : fundId // ignore: cast_nullable_to_non_nullable
as String,fundName: null == fundName ? _self.fundName : fundName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,subscribedAt: null == subscribedAt ? _self.subscribedAt : subscribedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveSubscriptionEntity].
extension ActiveSubscriptionEntityPatterns on ActiveSubscriptionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveSubscriptionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveSubscriptionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveSubscriptionEntity value)  $default,){
final _that = this;
switch (_that) {
case _ActiveSubscriptionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveSubscriptionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveSubscriptionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fundId,  String fundName,  double amount,  DateTime subscribedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveSubscriptionEntity() when $default != null:
return $default(_that.fundId,_that.fundName,_that.amount,_that.subscribedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fundId,  String fundName,  double amount,  DateTime subscribedAt)  $default,) {final _that = this;
switch (_that) {
case _ActiveSubscriptionEntity():
return $default(_that.fundId,_that.fundName,_that.amount,_that.subscribedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fundId,  String fundName,  double amount,  DateTime subscribedAt)?  $default,) {final _that = this;
switch (_that) {
case _ActiveSubscriptionEntity() when $default != null:
return $default(_that.fundId,_that.fundName,_that.amount,_that.subscribedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveSubscriptionEntity implements ActiveSubscriptionEntity {
  const _ActiveSubscriptionEntity({required this.fundId, required this.fundName, required this.amount, required this.subscribedAt});
  

@override final  String fundId;
@override final  String fundName;
@override final  double amount;
@override final  DateTime subscribedAt;

/// Create a copy of ActiveSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveSubscriptionEntityCopyWith<_ActiveSubscriptionEntity> get copyWith => __$ActiveSubscriptionEntityCopyWithImpl<_ActiveSubscriptionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSubscriptionEntity&&(identical(other.fundId, fundId) || other.fundId == fundId)&&(identical(other.fundName, fundName) || other.fundName == fundName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.subscribedAt, subscribedAt) || other.subscribedAt == subscribedAt));
}


@override
int get hashCode => Object.hash(runtimeType,fundId,fundName,amount,subscribedAt);

@override
String toString() {
  return 'ActiveSubscriptionEntity(fundId: $fundId, fundName: $fundName, amount: $amount, subscribedAt: $subscribedAt)';
}


}

/// @nodoc
abstract mixin class _$ActiveSubscriptionEntityCopyWith<$Res> implements $ActiveSubscriptionEntityCopyWith<$Res> {
  factory _$ActiveSubscriptionEntityCopyWith(_ActiveSubscriptionEntity value, $Res Function(_ActiveSubscriptionEntity) _then) = __$ActiveSubscriptionEntityCopyWithImpl;
@override @useResult
$Res call({
 String fundId, String fundName, double amount, DateTime subscribedAt
});




}
/// @nodoc
class __$ActiveSubscriptionEntityCopyWithImpl<$Res>
    implements _$ActiveSubscriptionEntityCopyWith<$Res> {
  __$ActiveSubscriptionEntityCopyWithImpl(this._self, this._then);

  final _ActiveSubscriptionEntity _self;
  final $Res Function(_ActiveSubscriptionEntity) _then;

/// Create a copy of ActiveSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fundId = null,Object? fundName = null,Object? amount = null,Object? subscribedAt = null,}) {
  return _then(_ActiveSubscriptionEntity(
fundId: null == fundId ? _self.fundId : fundId // ignore: cast_nullable_to_non_nullable
as String,fundName: null == fundName ? _self.fundName : fundName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,subscribedAt: null == subscribedAt ? _self.subscribedAt : subscribedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
