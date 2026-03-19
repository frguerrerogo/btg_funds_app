/// Transaction domain layer barrel file.
///
/// Exports the core domain components for transaction management, including
/// entities, repositories, and use cases. This module defines the business logic contracts,
/// data structures, and use case implementations for financial transactions in the
/// investment fund system.
library;

// Entities
export 'entities/transaction_entity.dart';
// Repositories
export 'repositories/transaction_repository.dart';
// Usecases
export 'usecases/get_history_use_case.dart';
