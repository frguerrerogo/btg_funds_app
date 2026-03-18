// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveSubscriptionDto _$ActiveSubscriptionDtoFromJson(
  Map<String, dynamic> json,
) => ActiveSubscriptionDto(
  fundId: json['fund_id'] as String,
  fundName: json['fund_name'] as String,
  amount: (json['amount'] as num).toDouble(),
  subscribedAt: json['subscribed_at'] as String,
);

Map<String, dynamic> _$ActiveSubscriptionDtoToJson(
  ActiveSubscriptionDto instance,
) => <String, dynamic>{
  'fund_id': instance.fundId,
  'fund_name': instance.fundName,
  'amount': instance.amount,
  'subscribed_at': instance.subscribedAt,
};
