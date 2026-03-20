import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show AlreadySubscribedException, FundEntity, FundsRepository, InsufficientBalanceException;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserRepository;

/// Use case that subscribes a user to a fund.
///
/// Depends on [FundsRepository] for fund data and [UserRepository] for user account updates.
class SubscribeFundUseCase {
  /// Creates a [SubscribeFundUseCase] with [fundsRepository] and [userRepository].
  const SubscribeFundUseCase({
    required FundsRepository fundsRepository,
    required UserRepository userRepository,
  }) : _fundsRepository = fundsRepository,
       _userRepository = userRepository;

  final FundsRepository _fundsRepository;
  final UserRepository _userRepository;

  /// Subscribes the user to the fund identified by [fundId] with [name] and [minimumAmount].
  /// Returns a [FundEntity] reflecting the subscribed fund.
  /// Throws [AlreadySubscribedException] if the user is already subscribed, or [InsufficientBalanceException] if the user has insufficient balance.
  Future<FundEntity> execute({
    required String fundId,
    required String name,
    required double minimumAmount,
  }) async {
    final user = await _userRepository.getUser();

    // Validation based on user activeSubscriptions
    if (user.isSubscribedToFund(fundId)) {
      throw const AlreadySubscribedException();
    }

    if (!user.hasEnoughBalance(minimumAmount)) {
      throw const InsufficientBalanceException();
    }

    final newBalance = user.balance - minimumAmount;
    await _userRepository.updateBalance(newBalance);
    await _userRepository.addActiveSubscription(
      ActiveSubscriptionEntity(
        fundId: fundId,
        fundName: name,
        amount: minimumAmount,
        subscribedAt: DateTime.now(),
      ),
    );

    return _fundsRepository.getFundById(fundId);
  }
}
