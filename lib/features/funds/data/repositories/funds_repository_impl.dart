import 'package:btg_funds_app/features/funds/data/datasources/funds_remote_datasource.dart';
import 'package:btg_funds_app/features/funds/data/mappers/fund_mapper.dart';
import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/features/funds/domain/repositories/funds_repository.dart';

/// Remote-based implementation of [FundsRepository].
class FundsRepositoryImpl implements FundsRepository {
  /// Creates a [FundsRepositoryImpl] with the given [datasource] and [mapper].
  const FundsRepositoryImpl({
    required FundsRemoteDatasource datasource,
    required FundMapper mapper,
  }) : _datasource = datasource,
       _mapper = mapper;

  final FundsRemoteDatasource _datasource;
  final FundMapper _mapper;

  @override
  Future<List<FundEntity>> getFunds() async {
    final dtos = await _datasource.getFunds();
    return _mapper.modelsToEntities(dtos);
  }

  @override
  Future<FundEntity> getFundById(String id) async {
    final dto = await _datasource.getFundById(id);
    return _mapper.modelToEntity(dto);
  }

  @override
  Future<FundEntity> subscribeFund(String fundId) async {
    final dto = await _datasource.subscribeFund(fundId);
    return _mapper.modelToEntity(dto);
  }

  @override
  Future<FundEntity> cancelFund(String fundId) async {
    final dto = await _datasource.cancelFund(fundId);
    return _mapper.modelToEntity(dto);
  }
}
