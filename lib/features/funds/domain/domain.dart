/// Funds domain layer barrel file.
///
/// Exports the core domain components for fund management, including
/// entities, exceptions, repositories, and use cases. This module defines
/// the business logic contracts and data structures for fund operations,
/// subscriptions, and balance management.
library;

// Entities
export 'entities/fund_entity.dart';
// Exceptions
export 'exceptions/already_subscribed_exception.dart';
export 'exceptions/insufficient_balance_exception.dart';
export 'exceptions/not_subscribed_exception.dart';
// Repositories
export 'repositories/funds_repository.dart';
export 'usecases/cancel_fund_use_case.dart';
// Usecases
export 'usecases/get_funds_use_case.dart';
export 'usecases/subscribe_fund_use_case.dart';
