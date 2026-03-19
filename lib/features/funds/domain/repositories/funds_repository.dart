import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity;

/// Repository interface for accessing and managing fund data.
/// Defines the domain contract for fund retrieval and subscription management.
abstract class FundsRepository {
  /// Retrieves all funds available in the investment platform. Returns a list of [FundEntity] representing all available funds.
  Future<List<FundEntity>> getFunds();

  /// Retrieves the fund identified by [id]. Returns the [FundEntity] matching the provided identifier.
  Future<FundEntity> getFundById(String id);

  /// Subscribes the current user to the fund identified by [fundId]. Returns the [FundEntity] reflecting the active subscription status.
  Future<FundEntity> subscribeFund(String fundId);

  /// Cancels the user's subscription to the fund identified by [fundId]. Returns the [FundEntity] reflecting the cancelled subscription status.
  Future<FundEntity> cancelFund(String fundId);
}
