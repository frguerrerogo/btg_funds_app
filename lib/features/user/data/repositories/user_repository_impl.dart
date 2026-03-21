import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionMapper, UserMapper, UserRemoteDatasource;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity, UserRepository;

/// Remote-based implementation of [UserRepository].
class UserRepositoryImpl implements UserRepository {
  /// Creates a [UserRepositoryImpl] with the given [userDatasource], [userMapper], and [activeSubscriptionMapper].
  const UserRepositoryImpl({
    required UserRemoteDatasource userDatasource,
    required UserMapper userMapper,
    required ActiveSubscriptionMapper activeSubscriptionMapper,
  }) : _userDatasource = userDatasource,
       _userMapper = userMapper,
       _activeSubscriptionMapper = activeSubscriptionMapper;

  final UserRemoteDatasource _userDatasource;
  final UserMapper _userMapper;
  final ActiveSubscriptionMapper _activeSubscriptionMapper;

  @override
  Future<UserEntity> getUser() async {
    final dto = await _userDatasource.getUser();
    return _userMapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> updateBalance(double newBalance) async {
    final dto = await _userDatasource.updateBalance(newBalance);
    return _userMapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> addActiveSubscription(ActiveSubscriptionEntity subscription) async {
    final model = _activeSubscriptionMapper.entityToModel(subscription);
    final dto = await _userDatasource.addActiveSubscription(model);
    return _userMapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> removeActiveSubscription(String fundId) async {
    final dto = await _userDatasource.removeActiveSubscription(fundId);
    return _userMapper.modelToEntity(dto);
  }
}
