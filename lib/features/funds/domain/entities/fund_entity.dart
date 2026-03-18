import 'package:freezed_annotation/freezed_annotation.dart';

part 'fund_entity.freezed.dart';

/// Classifies a fund based on its investment type and regulatory framework.
enum FundCategory {
  /// Fixed Portfolio Fund (Fundo de Portfólio Fechado) - a closed-end fund
  /// with a fixed portfolio of assets and a predetermined investment horizon.
  fpv,

  /// Fixed Income Fund (Fundo de Investimento em Cotas) - a fund that
  /// invests primarily in fixed income securities and debt instruments.
  fic,
}

/// Represents a financial fund available in the investment platform.
///
/// This domain entity encapsulates the core information of a fund, including
/// its identification, name, investment requirements, and the user's subscription status.
/// It provides utility methods to quickly identify the fund's category type.
@freezed
abstract class FundEntity with _$FundEntity {
  /// Creates a fund entity with the specified characteristics.
  ///
  /// [id] is the unique identifier for the fund.
  /// [name] is the display name of the fund.
  /// [minimumAmount] is the minimum investment amount required to subscribe to this fund.
  /// [category] classifies the fund as either FPV or FIC type.
  /// [isSubscribed] indicates whether the current user is already subscribed to this fund.
  const factory FundEntity({
    required String id,
    required String name,
    required double minimumAmount,
    required FundCategory category,
    @Default(false) bool isSubscribed,
  }) = _FundEntity;

  const FundEntity._();

  /// Returns true if this fund is categorized as FPV, false otherwise.
  bool get isFpv => category == FundCategory.fpv;

  /// Returns true if this fund is categorized as FIC, false otherwise.
  bool get isFic => category == FundCategory.fic;
}
