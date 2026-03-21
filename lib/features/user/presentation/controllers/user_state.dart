import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity;
import 'package:equatable/equatable.dart';

/// Represents the state of the user feature.
///
/// Encapsulates the current user's account data, balance, and active subscriptions.
class UserState extends Equatable {
  /// Creates a [UserState] with the given [user].
  const UserState({
    required this.user,
  });

  /// The current user's account and subscription information.
  final UserEntity user;

  /// Returns the number of active fund subscriptions.
  int get subscriptionCount => user.activeSubscriptions.length;

  /// Returns whether the user has sufficient balance for the given [amount].
  bool hasEnoughBalance(double amount) => user.hasEnoughBalance(amount);

  /// Returns whether the user is subscribed to the fund identified by [fundId].
  bool isSubscribedToFund(String fundId) => user.isSubscribedToFund(fundId);

  /// Returns the [ActiveSubscriptionEntity] for the fund identified by [fundId], or `null` if not subscribed.
  ActiveSubscriptionEntity? getSubscription(String fundId) => user.getSubscription(fundId);

  /// Returns a copy of this state with the given fields replaced.
  UserState copyWith({
    UserEntity? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
