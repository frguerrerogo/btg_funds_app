import 'package:btg_funds_app/features/funds/data/datasources/funds_remote_datasource.dart';
import 'package:btg_funds_app/features/funds/data/mappers/fund_mapper.dart';
import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/features/funds/domain/repositories/funds_repository.dart';

/// Remote-based implementation of [FundsRepository].
class FundsRepositoryImpl implements FundsRepository {
  /// Creates a [FundsRepositoryImpl] with the given [fundsDatasource] and [fundMapper].
  const FundsRepositoryImpl({
    required FundsRemoteDatasource fundsDatasource,
    required FundMapper fundMapper,
  }) : _fundsDatasource = fundsDatasource,
       _fundMapper = fundMapper;

  final FundsRemoteDatasource _fundsDatasource;
  final FundMapper _fundMapper;

  @override
  Future<List<FundEntity>> getFunds() async {
    final dtos = await _fundsDatasource.getFunds();
    return _fundMapper.modelsToEntities(dtos);
  }

  @override
  Future<FundEntity> getFundById(String id) async {
    final dto = await _fundsDatasource.getFundById(id);
    return _fundMapper.modelToEntity(dto);
  }
}
