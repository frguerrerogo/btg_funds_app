import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity, FundsRepository;

/// Encapsulates the business logic for retrieving all available funds.
///
/// This use case handles the domain rule of fetching the complete list of
/// investment funds that are accessible to users in the platform. It depends on
/// [FundsRepository] to retrieve the actual fund data.
class GetFundsUseCase {
  /// Initializes the use case with an instance of [_repository].
  ///
  /// [_repository] provides the data access contract for retrieving fund information
  /// from the underlying data source.
  const GetFundsUseCase(this._repository);

  final FundsRepository _repository;

  /// Executes the use case to retrieve all available funds from the repository.
  ///
  /// Returns a list of [FundEntity] objects representing all funds currently
  /// available for users to browse and subscribe to.
  Future<List<FundEntity>> execute() async {
    return _repository.getFunds();
  }
}
