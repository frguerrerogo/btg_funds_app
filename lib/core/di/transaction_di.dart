import 'package:btg_funds_app/core/core.dart' show dioClientProvider;
import 'package:btg_funds_app/features/transaction/data/data.dart'
    show
        TransactionMapper,
        TransactionRemoteDatasource,
        TransactionRemoteDatasourceImpl,
        TransactionRepositoryImpl;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show GetHistoryUseCase, SaveTransactionUseCase, TransactionRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Datasource
/// Provider for [TransactionRemoteDatasource], backed by [TransactionRemoteDatasourceImpl].
final transactionRemoteDatasourceProvider = Provider<TransactionRemoteDatasource>((ref) {
  return TransactionRemoteDatasourceImpl(ref.read(dioClientProvider));
});

// Mapper
/// Provider for [TransactionMapper].
final transactionMapperProvider = Provider<TransactionMapper>((ref) {
  return TransactionMapper();
});

// Repository
/// Provider for [TransactionRepository], backed by [TransactionRepositoryImpl].
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    datasource: ref.read(transactionRemoteDatasourceProvider),
    mapper: ref.read(transactionMapperProvider),
  );
});

// Use case
/// Provider for [GetHistoryUseCase].
final getHistoryUseCaseProvider = Provider<GetHistoryUseCase>((ref) {
  return GetHistoryUseCase(ref.read(transactionRepositoryProvider));
});

/// Provider for [SaveTransactionUseCase].
final saveTransactionUseCaseProvider = Provider<SaveTransactionUseCase>((ref) {
  return SaveTransactionUseCase(ref.read(transactionRepositoryProvider));
});
