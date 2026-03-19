import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show AlreadySubscribedException, FundEntity, FundsRepository, InsufficientBalanceException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserRepository;

/// Use case that subscribes a user to a fund with balance and subscription validation.
///
/// Depends on [FundsRepository] for fund subscription and [UserRepository] for balance verification and subscription tracking.
class SubscribeFundUseCase {
  /// Creates a [SubscribeFundUseCase] with [fundsRepository] and [userRepository].
  const SubscribeFundUseCase({
    required FundsRepository fundsRepository,
    required UserRepository userRepository,
  }) : _fundsRepository = fundsRepository,
       _userRepository = userRepository;

  final FundsRepository _fundsRepository;
  final UserRepository _userRepository;

  /// Subscribes the user to the fund identified by [fundId]. Returns a [FundEntity] reflecting the active subscription status. Throws [AlreadySubscribedException] if already subscribed, [InsufficientBalanceException] if balance is insufficient.
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
