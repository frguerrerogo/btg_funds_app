/// Exception thrown when a user attempts a transaction or investment operation.
/// The user's available balance is insufficient to cover the required amount.
class InsufficientBalanceException implements Exception {
  /// Creates an [InsufficientBalanceException].
  const InsufficientBalanceException();
}
