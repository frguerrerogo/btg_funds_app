import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show FundEntity, FundsRepository, NotSubscribedException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserRepository;

/// Use case that cancels a user's fund subscription.
///
/// Depends on [FundsRepository] for fund data and [UserRepository] for user account updates.
class CancelFundUseCase {
  /// Creates a [CancelFundUseCase] with [fundsRepository] and [userRepository].
  const CancelFundUseCase({
    required FundsRepository fundsRepository,
    required UserRepository userRepository,
  }) : _fundsRepository = fundsRepository,
       _userRepository = userRepository;

  final FundsRepository _fundsRepository;
  final UserRepository _userRepository;

  /// Cancels the fund subscription identified by [fundId].
  /// Returns a [FundEntity] reflecting the fund after cancellation.
  /// Throws [NotSubscribedException] if the user is not subscribed to the fund.
  Future<FundEntity> execute({required String fundId}) async {
    final user = await _userRepository.getUser();

    // Validation based on user activeSubscriptions
    if (!user.isSubscribedToFund(fundId)) {
      throw const NotSubscribedException();
    }

    // Refund exact amount invested
    final subscription = user.getSubscription(fundId);
    final refundAmount = subscription?.amount ?? 0;
    final newBalance = user.balance + refundAmount;

    await _userRepository.updateBalance(newBalance);
    await _userRepository.removeActiveSubscription(fundId);

    return _fundsRepository.getFundById(fundId);
  }
}
