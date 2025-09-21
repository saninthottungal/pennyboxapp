// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_with_balance.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountwBalance {

 int get id; String get accountName; double get balance;
/// Create a copy of AccountwBalance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountwBalanceCopyWith<AccountwBalance> get copyWith => _$AccountwBalanceCopyWithImpl<AccountwBalance>(this as AccountwBalance, _$identity);

  /// Serializes this AccountwBalance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountwBalance&&(identical(other.id, id) || other.id == id)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountName,balance);

@override
String toString() {
  return 'AccountwBalance(id: $id, accountName: $accountName, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $AccountwBalanceCopyWith<$Res>  {
  factory $AccountwBalanceCopyWith(AccountwBalance value, $Res Function(AccountwBalance) _then) = _$AccountwBalanceCopyWithImpl;
@useResult
$Res call({
 int id, String accountName, double balance
});




}
/// @nodoc
class _$AccountwBalanceCopyWithImpl<$Res>
    implements $AccountwBalanceCopyWith<$Res> {
  _$AccountwBalanceCopyWithImpl(this._self, this._then);

  final AccountwBalance _self;
  final $Res Function(AccountwBalance) _then;

/// Create a copy of AccountwBalance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountName = null,Object? balance = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountwBalance].
extension AccountwBalancePatterns on AccountwBalance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountwBalance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountwBalance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountwBalance value)  $default,){
final _that = this;
switch (_that) {
case _AccountwBalance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountwBalance value)?  $default,){
final _that = this;
switch (_that) {
case _AccountwBalance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String accountName,  double balance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountwBalance() when $default != null:
return $default(_that.id,_that.accountName,_that.balance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String accountName,  double balance)  $default,) {final _that = this;
switch (_that) {
case _AccountwBalance():
return $default(_that.id,_that.accountName,_that.balance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String accountName,  double balance)?  $default,) {final _that = this;
switch (_that) {
case _AccountwBalance() when $default != null:
return $default(_that.id,_that.accountName,_that.balance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountwBalance implements AccountwBalance {
  const _AccountwBalance({required this.id, required this.accountName, required this.balance});
  factory _AccountwBalance.fromJson(Map<String, dynamic> json) => _$AccountwBalanceFromJson(json);

@override final  int id;
@override final  String accountName;
@override final  double balance;

/// Create a copy of AccountwBalance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountwBalanceCopyWith<_AccountwBalance> get copyWith => __$AccountwBalanceCopyWithImpl<_AccountwBalance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountwBalanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountwBalance&&(identical(other.id, id) || other.id == id)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountName,balance);

@override
String toString() {
  return 'AccountwBalance(id: $id, accountName: $accountName, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$AccountwBalanceCopyWith<$Res> implements $AccountwBalanceCopyWith<$Res> {
  factory _$AccountwBalanceCopyWith(_AccountwBalance value, $Res Function(_AccountwBalance) _then) = __$AccountwBalanceCopyWithImpl;
@override @useResult
$Res call({
 int id, String accountName, double balance
});




}
/// @nodoc
class __$AccountwBalanceCopyWithImpl<$Res>
    implements _$AccountwBalanceCopyWith<$Res> {
  __$AccountwBalanceCopyWithImpl(this._self, this._then);

  final _AccountwBalance _self;
  final $Res Function(_AccountwBalance) _then;

/// Create a copy of AccountwBalance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountName = null,Object? balance = null,}) {
  return _then(_AccountwBalance(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
