/// Exception thrown when a user attempts to cancel a fund subscription they are not subscribed to.
///
/// This exception is raised in the fund cancellation workflow when the system validates
/// that the fund the user is trying to unsubscribe from does not have an active subscription
/// for that user. It indicates a precondition violation in the cancellation use case.
class NotSubscribedException implements Exception {
  /// Creates a [NotSubscribedException].
  const NotSubscribedException();
}
