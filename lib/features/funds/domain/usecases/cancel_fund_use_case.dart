import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show FundEntity, FundsRepository, NotSubscribedException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserRepository;

/// Use case that manages the cancellation of a user's fund subscription.
///
/// This use case encapsulates the business logic for unsubscribing from a fund,
/// including validation of subscription status, refund calculation, and balance updates.
/// It depends on [FundsRepository] to retrieve fund information and update its subscription state,
/// and [UserRepository] to manage user balance and subscription records.
class CancelFundUseCase {
  /// Creates an instance of [CancelFundUseCase].
  ///
  /// The [fundsRepository] is used to fetch fund data and update the fund subscription state.
  /// The [userRepository] is used to retrieve user information, update balance, and remove subscriptions.
  const CancelFundUseCase({
    required FundsRepository fundsRepository,
    required UserRepository userRepository,
  }) : _fundsRepository = fundsRepository,
       _userRepository = userRepository;

  final FundsRepository _fundsRepository;
  final UserRepository _userRepository;

  /// Cancels a user's subscription to a fund identified by [fundId].
  ///
  /// This method verifies that the user is currently subscribed to the fund,
  /// calculates the refund amount based on the subscription record,
  /// updates the user's balance with the refunded amount, removes the fund from
  /// the user's active subscriptions, and updates the fund's subscription state.
  ///
  /// Returns a [FundEntity] representing the fund after the subscription has been cancelled.
  ///
  /// Throws [NotSubscribedException] if the fund identified by [fundId] is not subscribed.
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
