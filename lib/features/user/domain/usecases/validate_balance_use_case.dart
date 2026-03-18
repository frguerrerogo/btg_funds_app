import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';

/// Use case that validates whether the user has sufficient balance for a transaction.
///
/// Encapsulates the business logic for checking fund availability before
/// allowing subscription or other balance-dependent operations. It retrieves
/// the current user profile from the repository and verifies the balance constraint.
class ValidateBalanceUseCase {
  /// Creates an instance of [ValidateBalanceUseCase].
  ///
  /// Requires a [_repository] implementation to fetch current user data
  /// for balance validation.
  const ValidateBalanceUseCase(this._repository);

  final UserRepository _repository;

  /// Validates whether the user has sufficient balance for the given amount.
  ///
  /// Fetches the current user profile and checks if their balance is sufficient
  /// to cover the requested [amount]. Returns `true` if the user has enough
  /// balance; `false` otherwise.
  Future<bool> execute({required double amount}) async {
    final user = await _repository.getUser();
    return user.hasEnoughBalance(amount);
  }
}
