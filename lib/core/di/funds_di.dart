import 'package:btg_funds_app/core/core.dart'
    show dioClientProvider, userMapperProvider, userRepositoryProvider;
import 'package:btg_funds_app/core/di/di.dart' show userRemoteDatasourceProvider;
import 'package:btg_funds_app/features/funds/data/data.dart'
    show FundMapper, FundsRemoteDatasource, FundsRemoteDatasourceImpl, FundsRepositoryImpl;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show CancelFundUseCase, FundsRepository, GetFundsUseCase, SubscribeFundUseCase;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Datasource
/// Provider for [FundsRemoteDatasource], backed by [FundsRemoteDatasourceImpl].
final fundsRemoteDatasourceProvider = Provider<FundsRemoteDatasource>((ref) {
  return FundsRemoteDatasourceImpl(ref.read(dioClientProvider));
});

// Mapper
/// Provider for [FundMapper].
final fundMapperProvider = Provider<FundMapper>((ref) {
  return FundMapper();
});

// Repository
/// Provider for [FundsRepository], backed by [FundsRepositoryImpl].
final fundsRepositoryProvider = Provider<FundsRepository>((ref) {
  return FundsRepositoryImpl(
    fundsDatasource: ref.read(fundsRemoteDatasourceProvider),
    fundMapper: ref.read(fundMapperProvider),
    userDatasource: ref.read(userRemoteDatasourceProvider),
    userMapper: ref.read(userMapperProvider),
  );
});

// Use cases
/// Provider for [GetFundsUseCase].
final getFundsUseCaseProvider = Provider<GetFundsUseCase>((ref) {
  return GetFundsUseCase(ref.read(fundsRepositoryProvider));
});

/// Provider for [SubscribeFundUseCase].
final subscribeFundUseCaseProvider = Provider<SubscribeFundUseCase>((ref) {
  return SubscribeFundUseCase(
    fundsRepository: ref.read(fundsRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
  );
});

/// Provider for [CancelFundUseCase].
final cancelFundUseCaseProvider = Provider<CancelFundUseCase>((ref) {
  return CancelFundUseCase(
    fundsRepository: ref.read(fundsRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
  );
});
