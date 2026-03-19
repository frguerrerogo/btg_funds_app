import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show FundEntity, FundsRepository, NotSubscribedException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserRepository;

/// Use case that cancels a user's fund subscription.
///
/// Depends on [FundsRepository] for fund cancellation and [UserRepository] for balance and subscription updates.
class CancelFundUseCase {
  /// Creates a [CancelFundUseCase] with [fundsRepository] and [userRepository].
  const CancelFundUseCase({
    required FundsRepository fundsRepository,
    required UserRepository userRepository,
  }) : _fundsRepository = fundsRepository,
       _userRepository = userRepository;

  final FundsRepository _fundsRepository;
  final UserRepository _userRepository;

  /// Cancels the user's subscription to the fund identified by [fundId]. Returns the [FundEntity] reflecting the cancelled subscription status. Throws [NotSubscribedException] if the user is not subscribed to the fund.
  Future<FundEntity> execute({required String fundId}) async {
    final user = await _userRepository.getUser();
    final fund = await _fundsRepository.getFundById(fundId);

    if (!fund.isSubscribed) {
      throw const NotSubscribedException();
    }

    final subscription = user.getSubscription(fundId);
    final refundAmount = subscription?.amount ?? fund.minimumAmount;
    final newBalance = user.balance + refundAmount;

    await _userRepository.updateBalance(newBalance);
    await _userRepository.removeSubscribedFund(fundId);

    return _fundsRepository.cancelFund(fundId);
  }
}
