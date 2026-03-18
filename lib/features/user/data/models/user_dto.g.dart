// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['id'] as String,
  name: json['name'] as String,
  balance: (json['balance'] as num).toDouble(),
  activeSubscriptions: (json['active_subscriptions'] as List<dynamic>)
      .map((e) => ActiveSubscriptionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'balance': instance.balance,
  'active_subscriptions': instance.activeSubscriptions,
};
