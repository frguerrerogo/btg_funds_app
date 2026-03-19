import 'package:btg_funds_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:btg_funds_app/features/user/data/mappers/user_mapper.dart';
import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';

/// Remote-based implementation of [UserRepository].
class UserRepositoryImpl implements UserRepository {
  /// Creates a [UserRepositoryImpl] with the given [datasource] and [mapper].
  const UserRepositoryImpl({
    required UserRemoteDatasource datasource,
    required UserMapper mapper,
  }) : _datasource = datasource,
       _mapper = mapper;

  final UserRemoteDatasource _datasource;
  final UserMapper _mapper;

  @override
  Future<UserEntity> getUser() async {
    final dto = await _datasource.getUser();
    return _mapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> updateBalance(double newBalance) async {
    final dto = await _datasource.updateBalance(newBalance);
    return _mapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> addSubscribedFund(String fundId) async {
    final dto = await _datasource.addSubscribedFund(fundId);
    return _mapper.modelToEntity(dto);
  }

  @override
  Future<UserEntity> removeSubscribedFund(String fundId) async {
    final dto = await _datasource.removeSubscribedFund(fundId);
    return _mapper.modelToEntity(dto);
  }
}
