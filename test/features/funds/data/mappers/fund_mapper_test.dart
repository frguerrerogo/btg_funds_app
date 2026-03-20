import 'package:btg_funds_app/features/funds/data/mappers/fund_mapper.dart';
import 'package:btg_funds_app/features/funds/data/models/fund_dto.dart';
import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [FundMapper].
  late FundMapper mapper;

  /// Base [FundDto] fixture with id '1', name 'FPV_BTG_PACTUAL_RECAUDADORA', and category 'FPV'.
  const tDto = FundDto(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: 'FPV',
  );

  /// Base [FundEntity] fixture with id '1', name 'FPV_BTG_PACTUAL_RECAUDADORA', and category [FundCategory.fpv].
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
        // act
        final result = mapper.modelToEntity(tDto);

        // assert
        expect(result, tEntity);
      });

      test('should map FPV category string to FundCategory.fpv', () {
        // act
        final result = mapper.modelToEntity(tDto);

        // assert
        expect(result.category, FundCategory.fpv);
      });

      test('should map FIC category string to FundCategory.fic', () {
        // arrange
        const ficDto = FundDto(
          id: '3',
          name: 'DEUDAPRIVADA',
          minimumAmount: 50000,
          category: 'FIC',
        );

        // act
        final result = mapper.modelToEntity(ficDto);

        // assert
        expect(result.category, FundCategory.fic);
      });
    });

    group('entityToModel', () {
      test('should map FundEntity to FundDto correctly', () {
        // act
        final result = mapper.entityToModel(tEntity);

        // assert
        expect(result.id, tEntity.id);
        expect(result.name, tEntity.name);
        expect(result.minimumAmount, tEntity.minimumAmount);
        expect(result.category, 'FPV');
      });
    });
  });
}
