// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundDto _$FundDtoFromJson(Map<String, dynamic> json) => FundDto(
  id: json['id'] as String,
  name: json['name'] as String,
  minimumAmount: (json['minimum_amount'] as num).toDouble(),
  category: json['category'] as String,
);

Map<String, dynamic> _$FundDtoToJson(FundDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'minimum_amount': instance.minimumAmount,
  'category': instance.category,
};
