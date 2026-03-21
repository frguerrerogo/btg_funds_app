import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity;
import 'package:equatable/equatable.dart';

/// Represents the state of the funds screen.
///
/// Encapsulates the list of available funds and the current user's account data.
class FundsState extends Equatable {
  /// Creates a [FundsState] with the given [funds] and [user].
  const FundsState({
    required this.funds,
    required this.user,
  });

  /// The list of available funds.
  final List<FundEntity> funds;

  /// The current user's account and subscription information.
  final UserEntity user;

  /// Returns whether the user has any active fund subscriptions.
  bool get hasSubscriptions => user.activeSubscriptions.isNotEmpty;

  /// Returns the list of funds to which the user is currently subscribed.
  List<FundEntity> get subscribedFunds => funds.where((f) => f.isSubscribed).toList();

  /// Returns the list of funds available for subscription.
  List<FundEntity> get availableFunds => funds.where((f) => !f.isSubscribed).toList();

  /// Returns a copy of this state with the given fields replaced.
  FundsState copyWith({
    List<FundEntity>? funds,
    UserEntity? user,
  }) {
    return FundsState(
      funds: funds ?? this.funds,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [funds, user];
}
