import 'package:btg_funds_app/core/network/dio_client.dart';
import 'package:btg_funds_app/features/user/data/data.dart' show UserDto;

/// Remote datasource interface for managing user data.
abstract class UserRemoteDatasource {
  /// Fetches user and returns a [UserDto].
  Future<UserDto> getUser();

  /// Updates user balance and returns a [UserDto].
  Future<UserDto> updateBalance(double newBalance);

  /// Adds a subscribed fund and returns a [UserDto].
  Future<UserDto> addSubscribedFund(String fundId);

  /// Removes a subscribed fund and returns a [UserDto].
  Future<UserDto> removeSubscribedFund(String fundId);
}

/// Dio-based implementation of [UserRemoteDatasource].
class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  /// Creates a [UserRemoteDatasourceImpl] with the given [_dioClient].
  const UserRemoteDatasourceImpl(this._dioClient);
  final DioClient _dioClient;

  @override
  Future<UserDto> getUser() async {
    final response = await _dioClient.dio.get<Map<String, dynamic>>('/user');
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> updateBalance(double newBalance) async {
    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      '/user',
      data: {'balance': newBalance},
    );
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> addSubscribedFund(String fundId) async {
    final user = await getUser();
    final updatedSubscriptions = [
      ...user.activeSubscriptions.map((s) => s.toJson()),
    ];
    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      '/user',
      data: {'active_subscriptions': updatedSubscriptions},
    );
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> removeSubscribedFund(String fundId) async {
    final user = await getUser();
    final updatedSubscriptions = user.activeSubscriptions
        .where((s) => s.fundId != fundId)
        .map((s) => s.toJson())
        .toList();
    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      '/user',
      data: {'active_subscriptions': updatedSubscriptions},
    );
    return UserDto.fromJson(response.data!);
  }
}
