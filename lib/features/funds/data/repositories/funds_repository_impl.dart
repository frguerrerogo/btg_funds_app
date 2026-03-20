import 'package:btg_funds_app/features/funds/data/datasources/funds_remote_datasource.dart';
import 'package:btg_funds_app/features/funds/data/mappers/fund_mapper.dart';
import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/features/funds/domain/repositories/funds_repository.dart';
import 'package:btg_funds_app/features/user/data/data.dart' show UserMapper, UserRemoteDatasource;

/// Remote-based implementation of [FundsRepository].
class FundsRepositoryImpl implements FundsRepository {
  /// Creates a [FundsRepositoryImpl] with the given [fundsDatasource], [userDatasource], [fundMapper], and [userMapper].
  const FundsRepositoryImpl({
    required FundsRemoteDatasource fundsDatasource,
    required UserRemoteDatasource userDatasource,
    required FundMapper fundMapper,
    required UserMapper userMapper,
  }) : _fundsDatasource = fundsDatasource,
       _userDatasource = userDatasource,
       _fundMapper = fundMapper,
       _userMapper = userMapper;

  final FundsRemoteDatasource _fundsDatasource;
  final UserRemoteDatasource _userDatasource;
  final FundMapper _fundMapper;
  final UserMapper _userMapper;

  Future<List<String>> _getSubscribedFundIds() async {
    final userDto = await _userDatasource.getUser();
    final userEntity = _userMapper.modelToEntity(userDto);
    return userEntity.activeSubscriptions.map((s) => s.fundId).toList();
  }

  @override
  Future<List<FundEntity>> getFunds() async {
    final dtos = await _fundsDatasource.getFunds();
    final subscribedIds = await _getSubscribedFundIds();
    return dtos.map((dto) => _fundMapper.toEntityWithSubscription(dto, subscribedIds)).toList();
  }

  @override
  Future<FundEntity> getFundById(String id) async {
    final dto = await _fundsDatasource.getFundById(id);
    final subscribedIds = await _getSubscribedFundIds();
    return _fundMapper.toEntityWithSubscription(dto, subscribedIds);
  }
}
