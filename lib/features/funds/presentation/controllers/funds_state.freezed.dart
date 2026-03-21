// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'funds_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FundsState {

 List<FundEntity> get funds; UserEntity get user;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FundsState&&const DeepCollectionEquality().equals(other.funds, funds)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(funds),user);

@override
String toString() {
  return 'FundsState(funds: $funds, user: $user)';
}


}




/// Adds pattern-matching-related methods to [FundsState].
extension FundsStatePatterns on FundsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FundsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FundsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FundsState value)  $default,){
final _that = this;
switch (_that) {
case _FundsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FundsState value)?  $default,){
final _that = this;
switch (_that) {
case _FundsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FundEntity> funds,  UserEntity user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FundsState() when $default != null:
return $default(_that.funds,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FundEntity> funds,  UserEntity user)  $default,) {final _that = this;
switch (_that) {
case _FundsState():
return $default(_that.funds,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FundEntity> funds,  UserEntity user)?  $default,) {final _that = this;
switch (_that) {
case _FundsState() when $default != null:
return $default(_that.funds,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _FundsState extends FundsState {
  const _FundsState({required final  List<FundEntity> funds, required this.user}): _funds = funds,super._();
  

 final  List<FundEntity> _funds;
@override List<FundEntity> get funds {
  if (_funds is EqualUnmodifiableListView) return _funds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_funds);
}

@override final  UserEntity user;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FundsState&&const DeepCollectionEquality().equals(other._funds, _funds)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_funds),user);

@override
String toString() {
  return 'FundsState(funds: $funds, user: $user)';
}


}




// dart format on
