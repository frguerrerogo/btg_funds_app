import 'package:freezed_annotation/freezed_annotation.dart';

part 'fund_entity.freezed.dart';

/// Classifies a fund by its investment structure and asset portfolio type.
enum FundCategory {
  /// Fixed Portfolio Fund - a closed-end fund with predetermined asset composition and investment horizon.
  fpv,

  /// Fixed Income Fund - a fund investing primarily in fixed income securities and debt instruments.
  fic,
}

/// Represents a financial fund available for investor subscriptions.
/// Encapsulates fund identification, name, minimum investment requirement, and category.
@freezed
abstract class FundEntity with _$FundEntity {
  /// Creates a fund with [id] and [name] for identification, [minimumAmount] for investment requirement, and [category] for fund classification.
  const factory FundEntity({
    required String id,
    required String name,
    required double minimumAmount,
    required FundCategory category,
  }) = _FundEntity;

  const FundEntity._();

  /// Returns `true` if [category] is [FundCategory.fpv], `false` otherwise.
  bool get isFpv => category == FundCategory.fpv;

  /// Returns `true` if [category] is [FundCategory.fic], `false` otherwise.
  bool get isFic => category == FundCategory.fic;
}
