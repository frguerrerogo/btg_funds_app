/// Exception thrown when an operation cannot be performed due to insufficient funds.
///
/// This domain exception is raised in business scenarios where the user attempts
/// to perform a transaction or investment operation such as subscribing to a fund
/// or making a withdrawal, but their available balance is not sufficient to cover
/// the required amount. This exception ensures proper validation of financial
/// constraints before executing monetary operations.
///
/// Implements [Exception] to integrate with Dart's exception handling mechanism.
class InsufficientBalanceException implements Exception {
  /// Creates an [InsufficientBalanceException].
  const InsufficientBalanceException();
}
