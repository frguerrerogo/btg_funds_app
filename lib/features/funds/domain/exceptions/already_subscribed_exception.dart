/// Exception thrown when a user attempts to subscribe to a fund.
/// The user already holds an active subscription in that fund.
class AlreadySubscribedException implements Exception {
  /// Creates an [AlreadySubscribedException].
  const AlreadySubscribedException();
}
