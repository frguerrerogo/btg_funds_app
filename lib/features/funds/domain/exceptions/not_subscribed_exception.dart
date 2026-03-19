/// Exception thrown when a user attempts to cancel a fund subscription.
/// The user is not subscribed to the requested fund.
class NotSubscribedException implements Exception {
  /// Creates a [NotSubscribedException].
  const NotSubscribedException();
}
