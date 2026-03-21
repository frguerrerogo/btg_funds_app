import 'package:btg_funds_app/core/network/dio_client.dart';
import 'package:btg_funds_app/features/funds/data/data.dart' show FundDto;

/// Remote datasource interface for managing funds data.
abstract class FundsRemoteDatasource {
  /// Fetches funds and returns a [List<FundDto>].
  Future<List<FundDto>> getFunds();

  /// Fetches fund by id and returns a [FundDto].
  Future<FundDto> getFundById(String id);
}

/// Dio-based implementation of [FundsRemoteDatasource].
class FundsRemoteDatasourceImpl implements FundsRemoteDatasource {
  /// Creates a [FundsRemoteDatasourceImpl] with the given [_dioClient].
  const FundsRemoteDatasourceImpl(this._dioClient);

  static const String _fundsEndpoint = '/funds';

  final DioClient _dioClient;

  @override
  Future<List<FundDto>> getFunds() async {
    final response = await _dioClient.dio.get<List<dynamic>>(_fundsEndpoint);
    return (response.data!).map((json) => FundDto.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<FundDto> getFundById(String id) async {
    final response = await _dioClient.dio.get<Map<String, dynamic>>('$_fundsEndpoint/$id');
    return FundDto.fromJson(response.data!);
  }
}
