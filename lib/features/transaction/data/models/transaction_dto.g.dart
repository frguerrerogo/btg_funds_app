// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    TransactionDto(
      id: json['id'] as String,
      fundId: json['fund_id'] as String,
      fundName: json['fund_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      notificationMethod: json['notification_method'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$TransactionDtoToJson(TransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fund_id': instance.fundId,
      'fund_name': instance.fundName,
      'amount': instance.amount,
      'type': instance.type,
      'notification_method': instance.notificationMethod,
      'created_at': instance.createdAt,
    };
