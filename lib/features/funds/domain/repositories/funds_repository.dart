import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity;

/// Defines the domain contract for accessing and managing fund data.
///
/// This abstract repository interface encapsulates all operations related to
/// fund management, including retrieval of available funds and user subscription
/// actions. Implementations of this interface are responsible for providing access
/// to fund information and handling subscription state changes.
abstract class FundsRepository {
  /// Retrieves all funds currently available in the investment platform.
  ///
  /// Returns a list of [FundEntity] objects representing all funds
  /// that users can browse and potentially subscribe to.
  Future<List<FundEntity>> getFunds();

  /// Retrieves a specific fund by its unique identifier.
  ///
  /// [id] is the unique identifier of the fund to retrieve.
  /// Returns a [FundEntity] matching the provided [id].
  Future<FundEntity> getFundById(String id);

  /// Subscribes the current user to a fund with the specified identifier.
  ///
  /// [fundId] is the unique identifier of the fund to subscribe to.
  /// Returns the updated [FundEntity] reflecting the active subscription status.
  Future<FundEntity> subscribeFund(String fundId);

  /// Cancels the current user's subscription to a fund.
  ///
  /// [fundId] is the unique identifier of the fund to unsubscribe from.
  /// Returns the updated [FundEntity] reflecting the cancelled subscription status.
  Future<FundEntity> cancelFund(String fundId);
}
