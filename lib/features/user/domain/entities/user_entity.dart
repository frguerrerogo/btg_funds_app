import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// Represents a user with their account balance and active fund subscriptions.
/// Encapsulates user identification, personal data, and investment portfolio.
@freezed
abstract class UserEntity with _$UserEntity {
  /// Creates a new [UserEntity] with [id], [name], [balance], and optionally [activeSubscriptions] for user identification and fund portfolio tracking.
  const factory UserEntity({
    required String id,
    required String name,
    required double balance,
    @Default([]) List<ActiveSubscriptionEntity> activeSubscriptions,
  }) = _UserEntity;

  const UserEntity._();

  /// Returns `true` if [balance] is sufficient to cover the required [amount], `false` otherwise.
  bool hasEnoughBalance(double amount) => balance >= amount;

  /// Returns the [ActiveSubscriptionEntity] for the fund identified by [fundId], or `null` if not subscribed.
  ActiveSubscriptionEntity? getSubscription(String fundId) =>
      activeSubscriptions.where((s) => s.fundId == fundId).firstOrNull;
}
