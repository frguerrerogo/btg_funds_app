// lib/features/transaction/data/datasources/transaction_remote_datasource.dart

import 'package:btg_funds_app/core/core.dart' show DioExceptionMapper;
import 'package:btg_funds_app/core/network/dio_client.dart';
import 'package:btg_funds_app/features/transaction/data/data.dart' show TransactionDto;
import 'package:dio/dio.dart';

/// Remote datasource interface for managing transaction data.
abstract class TransactionRemoteDatasource {
  /// Fetches transaction history and returns a [List<TransactionDto>].
  Future<List<TransactionDto>> getHistory();

  /// Saves transaction and returns a [TransactionDto].
  Future<TransactionDto> saveTransaction(TransactionDto transaction);
}

/// Dio-based implementation of [TransactionRemoteDatasource].
class TransactionRemoteDatasourceImpl implements TransactionRemoteDatasource {
  /// Creates a [TransactionRemoteDatasourceImpl] with the given [_dioClient].
  const TransactionRemoteDatasourceImpl(this._dioClient);

  static const String _transactionsEndpoint = '/transactions';

  final DioClient _dioClient;

  @override
  Future<List<TransactionDto>> getHistory() async {
    try {
      final response = await _dioClient.dio.get<List<dynamic>>(
        _transactionsEndpoint,
        queryParameters: {'_sort': 'created_at', '_order': 'desc'},
      );
      return (response.data!)
          .map((json) => TransactionDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    }
  }

  @override
  Future<TransactionDto> saveTransaction(TransactionDto transaction) async {
    try {
      final response = await _dioClient.dio.post<Map<String, dynamic>>(
        _transactionsEndpoint,
        data: transaction.toJson(),
      );
      return TransactionDto.fromJson(response.data!);
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    }
  }
}
