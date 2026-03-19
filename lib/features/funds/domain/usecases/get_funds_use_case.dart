import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity, FundsRepository;

/// Use case that retrieves all available investment funds.
///
/// Depends on [FundsRepository] for fund data retrieval.
class GetFundsUseCase {
  /// Creates a [GetFundsUseCase] with [repository].
  const GetFundsUseCase(FundsRepository repository) : _repository = repository;

  final FundsRepository _repository;

  /// Retrieves all available funds. Returns a list of [FundEntity] representing all investment funds available for subscription.
  Future<List<FundEntity>> execute() async {
    return _repository.getFunds();
  }
}
