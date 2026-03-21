import 'package:btg_funds_app/core/core.dart' show AppConstants;
import 'package:btg_funds_app/core/network/dio_client.dart';
import 'package:btg_funds_app/features/user/data/data.dart' show ActiveSubscriptionDto, UserDto;

/// Remote datasource interface for managing user data.
abstract class UserRemoteDatasource {
  /// Fetches the user and returns a [UserDto].
  Future<UserDto> getUser();

  /// Updates the user balance and returns a [UserDto].
  Future<UserDto> updateBalance(double newBalance);

  /// Adds an active subscription and returns a [UserDto].
  Future<UserDto> addActiveSubscription(ActiveSubscriptionDto subscription);

  /// Removes an active subscription identified by [fundId] and returns a [UserDto].
  Future<UserDto> removeActiveSubscription(String fundId);
}

/// Dio-based implementation of [UserRemoteDatasource].
class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  /// Creates a [UserRemoteDatasourceImpl] with the given [dioClient].
  const UserRemoteDatasourceImpl(DioClient dioClient) : _dioClient = dioClient;

  static const String _userEndpoint = '/user';

  final DioClient _dioClient;

  @override
  Future<UserDto> getUser() async {
    final response = await _dioClient.dio.get<Map<String, dynamic>>(
      '$_userEndpoint/${AppConstants.userId}',
    );
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> updateBalance(double newBalance) async {
    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      '$_userEndpoint/${AppConstants.userId}',
      data: {'balance': newBalance},
    );
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> addActiveSubscription(ActiveSubscriptionDto subscription) async {
    final user = await getUser();
    final updatedSubscriptions = [
      ...user.activeSubscriptions.map((s) => s.toJson()),
      subscription.toJson(),
    ];
    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      '$_userEndpoint/${AppConstants.userId}',
      data: {'active_subscriptions': updatedSubscriptions},
    );
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> removeActiveSubscription(String fundId) async {
    final user = await getUser();
    final updatedSubscriptions = user.activeSubscriptions
        .where((s) => s.fundId != fundId)
        .map((s) => s.toJson())
        .toList();
    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      '$_userEndpoint/${AppConstants.userId}',
      data: {'active_subscriptions': updatedSubscriptions},
    );
    return UserDto.fromJson(response.data!);
  }
}
