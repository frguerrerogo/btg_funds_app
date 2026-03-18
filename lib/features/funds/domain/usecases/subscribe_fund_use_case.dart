import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show AlreadySubscribedException, FundEntity, FundsRepository, InsufficientBalanceException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserRepository;

/// Subscribes a user to a fund applying business logic validations.
///
/// This use case encapsulates the business logic for fund subscription,
/// ensuring the user has sufficient balance and is not already subscribed.
/// It coordinates with [FundsRepository] to fetch fund details and process
/// subscriptions, and [UserRepository] to verify balance and record subscriptions.
class SubscribeFundUseCase {
  /// Creates an instance of [SubscribeFundUseCase].
  ///
  /// Requires [fundsRepository] to fetch and subscribe to funds,
  /// and [userRepository] to verify user balance and track subscriptions.
  const SubscribeFundUseCase({
    required FundsRepository fundsRepository,
    required UserRepository userRepository,
  }) : _fundsRepository = fundsRepository,
       _userRepository = userRepository;

  final FundsRepository _fundsRepository;
  final UserRepository _userRepository;

  /// Subscribes the user to a fund with balance and subscription validation.
  ///
  /// Verifies that the user is not already subscribed to the fund identified
  /// by [fundId] and has sufficient balance to cover the fund's minimum amount.
  /// If both conditions are satisfied, deducts the minimum amount from the user's
  /// balance, records the subscription, and returns the updated fund entity.
  ///
  /// Throws [AlreadySubscribedException] if the user is already subscribed
  /// to the fund.
  /// Throws [InsufficientBalanceException] if the user's current balance is
  /// insufficient to meet the fund's minimum required amount.
  ///
  /// Returns a [Future] that resolves to the [FundEntity] representing the
  /// successfully subscribed fund.
  Future<FundEntity> execute({required String fundId}) async {
    final user = await _userRepository.getUser();
    final fund = await _fundsRepository.getFundById(fundId);

    if (fund.isSubscribed) {
      throw const AlreadySubscribedException();
    }

    if (!user.hasEnoughBalance(fund.minimumAmount)) {
      throw const InsufficientBalanceException();
    }

    final newBalance = user.balance - fund.minimumAmount;
    await _userRepository.updateBalance(newBalance);
    await _userRepository.addSubscribedFund(fundId);

    return _fundsRepository.subscribeFund(fundId);
  }
}
