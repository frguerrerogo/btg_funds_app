import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionMapper, UserMapper, UserRemoteDatasource;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity, UserRepository;

/// Remote-based implementation of [UserRepository].
class UserRepositoryImpl implements UserRepository {
  /// Creates a [UserRepositoryImpl] with the given [userSatasource], [userMapper], and [activeSubscriptionMapper].
  const UserRepositoryImpl({
    required UserRemoteDatasource userSatasource,
    required UserMapper userMapper,
    required ActiveSubscriptionMapper activeSubscriptionMapper,
  }) : _userSatasource = userSatasource,
       _userMapper = userMapper,
       _activeSubscriptionMapper = activeSubscriptionMapper;

  final UserRemoteDatasource _userSatasource;
  final UserMapper _userMapper;
  final ActiveSubscriptionMapper _activeSubscriptionMapper;

  @override
  Future<UserEntity> getUser() async {
    final dto = await _userSatasource.getUser();
    return _userMapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> updateBalance(double newBalance) async {
    final dto = await _userSatasource.updateBalance(newBalance);
    return _userMapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> addActiveSubscription(ActiveSubscriptionEntity subscription) async {
    final model = _activeSubscriptionMapper.entityToModel(subscription);
    final dto = await _userSatasource.addActiveSubscription(model);
    return _userMapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> removeActiveSubscription(String fundId) async {
    final dto = await _userSatasource.removeActiveSubscription(fundId);
    return _userMapper.modelToEntity(dto);
  }
}
