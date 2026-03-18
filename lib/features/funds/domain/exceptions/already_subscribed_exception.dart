/// Exception thrown when attempting to subscribe to a fund that is already subscribed.
///
/// This domain exception is raised when a user tries to subscribe to a fund
/// in which they already hold an active subscription. This prevents duplicate
/// subscriptions and maintains data integrity and consistency in the user's
/// investment portfolio.
///
/// Implements [Exception] to integrate with Dart's exception handling mechanism.
class AlreadySubscribedException implements Exception {
  /// Creates an [AlreadySubscribedException].
  const AlreadySubscribedException();
}
