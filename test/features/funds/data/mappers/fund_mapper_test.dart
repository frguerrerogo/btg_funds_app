import 'package:btg_funds_app/features/funds/data/mappers/fund_mapper.dart';
import 'package:btg_funds_app/features/funds/data/models/fund_dto.dart';
import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [FundMapper].
  late FundMapper mapper;

  /// Base [FundDto] fixture with minimumAmount 75000 and FPV category.
  const tDto = FundDto(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: 'FPV',
  );

  /// [FundDto] fixture with FIC category for testing enum mapping.
  const tFicDto = FundDto(
    id: '3',
    name: 'DEUDAPRIVADA',
    minimumAmount: 50000,
    category: 'FIC',
  );

  /// Base [FundEntity] fixture with minimumAmount 75000 and fpv category.
  const tEntity = FundEntity(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.fpv,
  );

  setUp(() {
    mapper = FundMapper();
  });

  group('FundMapper', () {
    group('modelToEntity', () {
      test('should map FundDto to FundEntity correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result, tEntity);
      });

      test('should map FPV category string to FundCategory.fpv', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.category, FundCategory.fpv);
      });

      test('should map FIC category string to FundCategory.fic', () {
        final result = mapper.modelToEntity(tFicDto);
        expect(result.category, FundCategory.fic);
      });

      test('should map id correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.id, '1');
      });

      test('should map minimumAmount correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.minimumAmount, 75000);
      });

      test('should default isSubscribed to false', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.isSubscribed, false);
      });
    });

    group('entityToModel', () {
      test('should map FundEntity to FundDto correctly', () {
        final result = mapper.entityToModel(tEntity);
        expect(result.id, tEntity.id);
        expect(result.name, tEntity.name);
        expect(result.minimumAmount, tEntity.minimumAmount);
        expect(result.category, 'FPV');
      });

      test('should map FIC category to string', () {
        const ficEntity = FundEntity(
          id: '3',
          name: 'DEUDAPRIVADA',
          minimumAmount: 50000,
          category: FundCategory.fic,
        );
        final result = mapper.entityToModel(ficEntity);
        expect(result.category, 'FIC');
      });
    });

    group('modelsToEntities', () {
      test('should map list of dtos to list of entities', () {
        final result = mapper.modelsToEntities([tDto, tFicDto]);
        expect(result.length, 2);
        expect(result.first.category, FundCategory.fpv);
        expect(result.last.category, FundCategory.fic);
      });
    });
  });
}
