import 'package:btg_funds_app/features/user/domain/domain.dart' show UserRepository;

/// Use case that validates whether the user has sufficient balance for a transaction.
///
/// Depends on [UserRepository] for user balance information.
class ValidateBalanceUseCase {
  /// Creates a [ValidateBalanceUseCase] with [repository].
  const ValidateBalanceUseCase(UserRepository repository) : _repository = repository;
  final UserRepository _repository;

  /// Validates whether the user's balance is sufficient for the amount specified by [amount]. Returns `true` if balance is sufficient, `false` otherwise.
  Future<bool> execute({required double amount}) async {
    final user = await _repository.getUser();
    return user.hasEnoughBalance(amount);
  }
}
