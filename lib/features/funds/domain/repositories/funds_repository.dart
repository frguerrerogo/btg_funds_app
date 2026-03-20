import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity;

/// Repository interface for accessing fund data.
/// Defines the domain contract for fund retrieval.
abstract class FundsRepository {
  /// Retrieves all funds available in the investment platform. Returns a list of [FundEntity] representing all available funds.
  Future<List<FundEntity>> getFunds();

  /// Retrieves the fund identified by [id]. Returns the [FundEntity] matching the provided identifier.
  Future<FundEntity> getFundById(String id);
}
