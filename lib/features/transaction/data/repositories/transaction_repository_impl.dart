import 'package:btg_funds_app/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:btg_funds_app/features/transaction/data/mappers/transaction_mapper.dart';
import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:btg_funds_app/features/transaction/domain/repositories/transaction_repository.dart';

/// Remote-based implementation of [TransactionRepository].
class TransactionRepositoryImpl implements TransactionRepository {
  /// Creates a [TransactionRepositoryImpl] with the given [datasource] and [mapper].
  const TransactionRepositoryImpl({
    required TransactionRemoteDatasource datasource,
    required TransactionMapper mapper,
  }) : _datasource = datasource,
       _mapper = mapper;

  final TransactionRemoteDatasource _datasource;
  final TransactionMapper _mapper;

  @override
  Future<List<TransactionEntity>> getHistory() async {
    final dtos = await _datasource.getHistory();
    return _mapper.modelsToEntities(dtos);
  }

  @override
  Future<TransactionEntity> saveTransaction(TransactionEntity transaction) async {
    final dto = _mapper.entityToModel(transaction);
    final savedDto = await _datasource.saveTransaction(dto);
    return _mapper.modelToEntity(savedDto);
  }
}
