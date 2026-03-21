import 'package:btg_funds_app/features/funds/domain/domain.dart' show NotSubscribedException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity, UserRepository;

/// Use case that cancels a user's fund subscription.
///
/// Depends on [UserRepository] for user account updates.
class CancelFundUseCase {
  /// Creates a [CancelFundUseCase] with [userRepository].
  const CancelFundUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  /// Cancels the fund subscription identified by [fundId].
  /// Returns a [UserEntity] with the removed subscription and refunded balance.
  /// Throws [NotSubscribedException] if the user is not subscribed to the fund.
  Future<UserEntity> execute({required UserEntity user, required String fundId}) async {
    // Validation based on user activeSubscriptions
    if (!user.isSubscribedToFund(fundId)) {
      throw const NotSubscribedException();
    }

    // Refund exact amount invested
    final subscription = user.getSubscription(fundId);
    final refundAmount = subscription?.amount ?? 0;
    final newBalance = user.balance + refundAmount;

    await _userRepository.updateBalance(newBalance);
    final updatedUser = await _userRepository.removeActiveSubscription(fundId);

    return updatedUser;
  }
}
